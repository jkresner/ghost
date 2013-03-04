Template.roomList.Rooms = ->
  Session.get 'roomsListRooms'

setRoomsListRooms = ->

  foundLocation = (location) ->
    # Session.set('loc','lat: '+location.coords.latitude+', lan: '+ location.coords.longitude);
    console.log('lat: ' + location.coords.latitude = ' lon: '+ location.coords.longitude)
    Session.set 'roomsListRooms', Rooms.find().fetch() #closeby


  noLocation = ->
    console.log("no location found")
    Session.set 'roomsListRooms', Rooms.find().fetch() #most popular

  getGeoLocation(Meteor.user, foundLocation, noLocation)


Template.roomList.avatarName  = ->
  user = Meteor.user
  if isAvatarExpired(user)
    generateAvatar(user)
  user.avatar.name

Template.roomList.avatarUrl = ->
  user = Meteor.user
  if isAvatarExpired(user)
    generateAvatar(user)
  user.avatar.img

