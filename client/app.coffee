Meteor.autorun ->
  Meteor.subscribe 'room_threads', Session.get('roomId')
  Meteor.subscribe 'user_avatars', Meteor.userId()
  Meteor.subscribe 'rooms'

Accounts.ui.config
  requestPermissions:
    facebook: ['email', 'user_events', 'user_groups', 'read_friendlists', 'publish_actions', ]

Meteor.startup ->
  Session.set 'loc', '?'

  $ ->
    window.router = new GhostRouter()
    Backbone.history.start pushState: false
