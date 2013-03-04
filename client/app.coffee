
if Meteor.isClient
  $log 'welcome to ghost post'



Accounts.ui.config
  requestPermissions:
    facebook: ['email', 'user_events', 'user_groups', 'read_friendlists', 'publish_actions', ]
