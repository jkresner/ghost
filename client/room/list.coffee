Template.roomList.rooms = ->
  Session.get 'roomsListRooms'

setRoomsListRooms = ->

  console.log("setRoomsListRooms() is being executed")

  foundLocation = (location) ->
    # Session.set('loc','lat: '+location.coords.latitude+', lan: '+ location.coords.longitude);
    console.log('Looking for rooms close to lat: ' + location.coords.latitude = ' lon: '+ location.coords.longitude)
    # once we use MongoDB that support geospatial operations:     rooms = Rooms.find({ loc: { $near: [ location.coords.longitude, location.coords.latitude ] } }).fetch()
    Session.set 'userLoc', [location.coords.longitude, location.coords.latitude]
    rooms = Rooms.find().fetch()
    Session.set 'roomsListRooms', rooms

  noLocation = ->
    console.log("no location found")
    Session.set 'roomsListRooms', Rooms.find().fetch() #most popular
    console.log("roomsListRooms", Rooms.find().fetch())

  getGeoLocation(Meteor.user, foundLocation, noLocation)

distance = (lon1, lat1, lon2, lat2) ->
  radlat1 = Math.PI * lat1 / 180
  radlat2 = Math.PI * lat2 / 180
  radlon1 = Math.PI * lon1 / 180
  radlon2 = Math.PI * lon2 / 180
  theta = lon1 - lon2
  radtheta = Math.PI * theta / 180
  dist = Math.sin(radlat1) * Math.sin(radlat2) + Math.cos(radlat1) * Math.cos(radlat2) * Math.cos(radtheta)
  dist = Math.acos(dist)
  dist = dist * 180 / Math.PI
  dist = dist * 60 * 1.1515
  dist

Template.roomList.hasLocation = ->
  if @loc
    if @loc[1] != null
      if @loc[1] > 0
        return true
      else
        return false
    else
      return false
  else
    return false

Template.roomList.getDistanceToUser = ->
  if Session.get 'userLoc'
    userLoc = Session.get 'userLoc'
    (Math.round(distance(@loc[0],@loc[1],userLoc[0], userLoc[1])*100)/100) + " miles away"

