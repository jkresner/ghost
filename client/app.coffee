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
      up = Avatars.update({_id: avatar._id}, {$set: {userId: Meteor.userId()}})
      debugger
    window.history.back()
    window.history.back()
  login(opts, newCallback)


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


Meteor.startup ->
  #geo.setUserLocation()

  $ ->
    window.router = new GhostRouter()
    Backbone.history.start pushState: false


Template.setup.created = ->
  $log 'adding google analytics'
  # window._gaq = _gaq || [];
  # _gaq.push(['_setAccount', 'UA-38990344-1'])
  # _gaq.push(['_setDomainName', 'ghostpost.io'])
  # _gaq.push(['_trackPageview'])

  # (->
  #   ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
  #   gajs = '.google-analytics.com/ga.js'
  #   ga.src = if document.location.protocol is 'https:' then 'https://ssl'+gajs else 'https://www'+gajs
  #   s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s)
  # )()
