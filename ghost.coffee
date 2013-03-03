if Meteor.isClient
  setTimeout -> document.body.appendChild Meteor.render ->
    Template.roomDetail Rooms.findOne(), 1000

if Meteor.isServer
  room = Rooms.insert({name: "testroom"})
  Threads.insert({roomId: room.id})
  Messages.insert({threadId: room.id, text: "here is a sample ghost post"})
  Messages.insert({threadId: room.id, text: "Ha you suck."})
  Meteor.startup ->
    # code to run on server at startup 
    console.log "YAY"
