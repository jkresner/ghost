permissions = ['email', 'user_events', 'user_groups', 'read_friendlists', 'publish_actions', ]
Accounts.ui.config
  requestPermissions:
    facebook: permissions

Meteor.loginWithFacebook  = _.wrap Meteor.loginWithFacebook, (login, opts, callback) ->
  newCallback = ->
    callback()
    # Set session avatar
    avatar = Session.get('avatar')
    if ! avatar.userId?
      Avatars.update({_id: avatar._id}, {userId: Meteor.userId()})
    window.history.back()
  login(opts, callback)

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


  geo.getGeoLocation(geoRoomSubcribe, roomSubcribe, {timeout: 8000})


  Meteor.subscribe 'room_messages', roomId, ->



Meteor.startup ->

  $ ->
    window.router = new GhostRouter()
    Backbone.history.start pushState: false
