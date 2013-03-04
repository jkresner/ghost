Accounts.ui.config
  requestPermissions:
    facebook: ['email', 'user_events', 'user_groups', 'read_friendlists', 'publish_actions', ]

Meteor.startup ->

  $ ->
    window.router = new GhostRouter()
    Backbone.history.start pushState: true
