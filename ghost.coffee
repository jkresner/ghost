if Meteor.isClient

if Meteor.isServer
  if Rooms.count == 0
    room = Rooms.insert({name: "testroom"})
    Threads.insert({roomId: room.id})
    Messages.insert({threadId: room.id, text: "here is a sample ghost post", created_at: new Date().})
    Messages.insert({threadId: room.id, text: "Ha you suck.", created_at: new Date().})
    Meteor.startup ->
    # code to run on server at startup 

  console.log "YAY"
