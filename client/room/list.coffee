Template.roomList.popularRooms = ->
  Rooms.find({})


Template.roomList.myRooms = ->
  Rooms.find({owner: getUserId()})


Template.roomList.rooms = ->
  Rooms.find().fetch()
  #Session.get 'roomsListRooms'





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
  if Session.get('userLoc')?
    Math.round( distance( @loc[0], @loc[1], Session.get('userLoc')[0], Session.get('userLoc')[1] ) *100 ) / 100 + " mi - "


Template.roomList.events
  'click #room-tabs a': (evt) ->
    elt = $(evt.currentTarget)
    $('#room-tab-content .tab').hide()
    $('#' + elt.data('tab')).show()

