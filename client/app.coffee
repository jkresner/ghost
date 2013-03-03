Template.hello.greeting = ->
  greeting = "Welcome to ghost."
  usr = Meteor.user()
  if usr?
    fbid = usr.profile.facebook.id
    greeting = "<img src='http://graph.facebook.com/#{fbid}/picture'/>"

Template.hello.events
  'click input': ->
    if typeof console isnt 'undefined'
      console.log "You pressed the button"


if Meteor.isClient
  document.body.appendChild Meteor.render ->
    Template.roomDetail Rooms.findOne()
  $log 'welcome to ghost post'



Accounts.ui.config
  requestPermissions:
    facebook: ['email', 'user_events', 'user_groups', 'read_friendlists', 'publish_actions', ]
