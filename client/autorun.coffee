Meteor.autorun ->

  roomId = Session.get('roomId')

  setCurrentRoom = ->
    $log 'setCurrentRoom', roomId
    if roomId? then Session.set 'room', Rooms.findOne(roomId)

  roomSubscribe = (lat, lon) ->
    $log 'roomSubscribe', lat, lon
    Meteor.subscribe 'rooms', lat, lon, setCurrentRoom

  geoRoomSubscribe = (l) ->
    $log 'geoRoomSubscribe', l
    roomSubscribe l.coords.latitude, l.coords.longitude


  geo.getGeoLocation(geoRoomSubscribe, roomSubscribe, {timeout: 8000})


  Meteor.subscribe 'room_messages', roomId, ->


