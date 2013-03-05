Accounts.ui.config
  requestPermissions:
    facebook: ['email', 'user_events', 'user_groups', 'read_friendlists', 'publish_actions', ]


Meteor.autorun ->
  Meteor.subscribe 'rooms'
  Meteor.subscribe 'room_threads', Session.get('roomId')
  $log "Meteor.autorun.userId", Meteor.userId()
  #Meteor.subscribe 'user_avatars', Meteor.userId()


Meteor.startup ->
  Session.set 'loc', '?'

  $ ->
    window.router = new GhostRouter()
    Backbone.history.start pushState: false