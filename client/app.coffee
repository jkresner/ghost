Accounts.ui.config
  requestPermissions:
    facebook: ['email', 'user_events', 'user_groups', 'read_friendlists', 'publish_actions', ]



Meteor.autorun ->

  roomId = Session.get('roomId')

  setCurrentRoom = ->
    $log 'setCurrentRoom', roomId
    if roomId? then Session.set 'room', Rooms.findOne(roomId)

  roomSubcribe = (lat, lon) ->
    $log 'roomSubcribe', lat, lon
    Meteor.subscribe 'rooms', lat, lon, setCurrentRoom

  geoRoomSubcribe = (l) ->
    $log 'geoRoomSubcribe', l
    roomSubcribe l.coords.latitude, l.coords.longitude


  geo.getGeoLocation(geoRoomSubcribe, roomSubcribe)


  Meteor.subscribe 'room_messages', roomId, ->



Meteor.startup ->

  $ ->
    window.router = new GhostRouter()
    Backbone.history.start pushState: false