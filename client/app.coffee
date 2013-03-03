if Meteor.isClient
  Template.hello.greeting = -> "Welcome to ghost."

  Template.hello.events
    'click input': ->
      if typeof console isnt 'undefined'
        console.log "You pressed the button"

if Meteor.isServer
  Meteor.startup ->
    # code to run on server at startup 
    console.log "YAY"
