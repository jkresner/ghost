Meteor.publish 'rooms', (lat,long) ->
  Rooms.find()
  #Rooms.find loc : { $within : { $box : box } }
  #Rooms.find({ loc : { $within : { $box : box }}})
  #Rooms.find(geoNear: "places", near: [ -74, 40.74 ], spherical: true).fetch()


Meteor.publish 'room_messages', (roomId) -> Messages.find({roomId: roomId}, {sort: {createdAt: -1}})