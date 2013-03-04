Template.roomList.Rooms = ->
  Session.get 'roomsListRooms'

setRoomsListRooms = ->

  foundLocation = (location) ->
    # Session.set('loc','lat: '+location.coords.latitude+', lan: '+ location.coords.longitude);
    console.log('Looking for rooms close to lat: ' + location.coords.latitude = ' lon: '+ location.coords.longitude)
    alert 'Looking for rooms close to lat: ' + location.coords.latitude + '   long: '+ location.coords.longitude
    Session.set 'roomsListRooms', Rooms.find().fetch() #closeby

  noLocation = ->
    console.log("no location found")
    Session.set 'roomsListRooms', Rooms.find().fetch() #most popular

  getGeoLocation(Meteor.user, foundLocation, noLocation)

distance = (lat1, lon1, lat2, lon2) ->
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

Template.roomList.avatar  = -> Session.get 'avatar'
