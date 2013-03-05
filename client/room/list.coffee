Template.roomList.popularRooms = ->
  Rooms.find({})


Template.roomList.myRooms = ->
  Rooms.find({owner: getUserId()})


Template.roomList.rooms = ->
  Rooms.find().fetch()
  #Session.get 'roomsListRooms'


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


Template.roomList.events
  'click #room-tabs a': (evt) ->
    debugger
    elt = $(evt.currentTarget)
    $('#room-tab-content .tab').hide()
    $('#' + elt.data('tab')).show()

