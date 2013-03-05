Meteor.publish 'rooms', (lat,lon) ->

  # checking if lon exists. lat can also contain an error message (if the user denies geoLocation)
  if lon?
    Rooms.find( { loc : { $near: [lon, lat] } } )
    console.log 'publish.rooms', lat, lon
    console.log  Rooms.find( { loc : { $near: [lon, lat] } } ).fetch()

  else
    Rooms.find()
    console.log 'publish.rooms without location lat:', lat, ' lon: ', lon
    console.log Rooms.find().fetch()

  #Rooms.find()
  #Rooms.find loc : { $within : { $box : box } }
  #Rooms.find({ loc : { $within : { $box : box }}})
  #Rooms.find(geoNear: "places", near: [ -74, 40.74 ], spherical: true).fetch()


Meteor.publish 'room_messages', (roomId) ->
  Messages.find({roomId: roomId}, {sort: {createdAt: -1}})
