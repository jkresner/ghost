setCurrentRoom = ->
  roomId = Session.get('roomId')
  $log 'autorun.setCurrentRoom', roomId
  if roomId?
    set = ->
      Session.set 'room', Rooms.findOne({name: roomId})
      Meteor.subscribe 'room_messages', roomId, ->
    if Rooms? then set() else roomSubscribe(null, null, set)


roomSubscribe = (lat, lon, callback) ->
  $log 'roomSubscribe' #, lat, lon
  Meteor.subscribe 'rooms', lat, lon, callback


Meteor.autorun ->
  user = Meteor.user()
  if user?
    Meteor.subscribe 'user_avatars', user._id, ->
      validAvatar = getValidUserAvatar(user)
      $log 'autorun.validAvatar', validAvatar
      Session.set 'avatar', validAvatar


Meteor.autorun ->
  setCurrentRoom()



Meteor.autorun ->
  # we assume geo location is going to fail
  roomSubscribe(null, null, setCurrentRoom)

