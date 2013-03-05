Meteor.publish 'rooms', ->
  # Rooms.find({ loc : { $within : { $box : box }}})
  console.log 'publish.rooms'
  rooms = Rooms.find(geoNear: "places", near: [ -74, 40.74 ], spherical: true).fetch()
  console.log "rooms", rooms
  rooms

Meteor.publish 'user_avatars', (userId) -> Avatars.find({userId: userId})

Meteor.publish 'room_messages', (roomId) -> Messages.find({roomId: roomId}, {sort: {createdAt: -1}})
