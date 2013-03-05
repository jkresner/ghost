Meteor.publish 'rooms', (lat,lon) ->

  # checking if lon exists. lat can also contain an error message (if the user denies geoLocation)
  if lon?
    console.log 'publish.rooms', lat, lon
    console.log  Rooms.find( { loc : { $near: [lon, lat] } } ).fetch()
    Rooms.find( { loc : { $near: [lon, lat] } } )


  else
    console.log 'Not submitting near rooms due to lack of User geoLocation'
    Rooms.find({})

  #Rooms.find()
  #Rooms.find loc : { $within : { $box : box } }
  #Rooms.find({ loc : { $within : { $box : box }}})
  #Rooms.find(geoNear: "places", near: [ -74, 40.74 ], spherical: true).fetch()


Meteor.publish 'room_messages', (roomId) ->
  Messages.find({roomId: roomId}, {sort: {createdAt: -1}})
