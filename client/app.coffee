Accounts.ui.config
  requestPermissions:
    facebook: ['email', 'user_events', 'user_groups', 'read_friendlists', 'publish_actions', ]


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

  roomSubscribe = (lat, lon) ->
    $log 'roomSubscribe', lat, lon
    Meteor.subscribe 'rooms', lat, lon, setCurrentRoom

  geoRoomSubscribe = (l) ->
    $log 'geoRoomSubscribe', l
    roomSubscribe l.coords.latitude, l.coords.longitude

  noLocation = -> console.log('not location')

  geo.getGeoLocation(geoRoomSubscribe, roomSubscribe)


  Meteor.subscribe 'room_messages', roomId, ->



Meteor.startup ->
  # geo.setUserLocation()

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