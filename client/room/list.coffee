# Template.roomList.popularRooms = ->
#   Rooms.find {score: {$gt: 0}}, {sort: {score: -1}}

# Template.roomList.myRooms = ->
#   Rooms.find({owner: getUserId()})

Template.roomList.rooms = ->
  method = 'all'
  if method is 'all'
    Rooms.find()

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

