Accounts.ui.config
  requestPermissions:
    facebook: ['email', 'user_events', 'user_groups', 'read_friendlists', 'publish_actions', ]


Meteor.autorun ->
  Meteor.subscribe 'rooms', setRoomsListRooms
  Meteor.subscribe 'room_threads', Session.get('roomId')
  $log "Meteor.autorun.userId", Meteor.userId()
  #Meteor.subscribe 'user_avatars', Meteor.userId()


Meteor.startup ->
  Session.set 'loc', '?'
  Meteor.call 'getAvatarImages', (err, avatar_images) ->
    Session.set 'avatar_images', avatar_images

  $ ->
    window.router = new GhostRouter()
    Backbone.history.start pushState: false
