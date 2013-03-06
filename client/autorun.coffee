setCurrentRoom = ->
  roomId = Session.get('roomId')
  $log 'autorun.setCurrentRoom', roomId
  if roomId?
    set = ->
      Session.set 'room', Rooms.findOne(roomId)
      Meteor.subscribe 'room_messages', roomId, ->
    if Rooms? then set() else roomSubscribe(null, null, set)


roomSubscribe = (lat, lon, callback) ->
  $log 'roomSubscribe' #, lat, lon
  Meteor.subscribe 'rooms', lat, lon, callback


Meteor.autorun ->
  setCurrentRoom()

Meteor.autorun ->
  #geoRoomSubscribe = (l) ->
  #  $log 'geoRoomSubscribe', l
  #  roomSubscribe l.coords.latitude, l.coords.longitude

  #geo.getGeoLocation(geoRoomSubscribe)

  # we assume geo location is going to fail
  roomSubscribe(null, null, setCurrentRoom)