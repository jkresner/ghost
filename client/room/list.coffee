Template.roomList.rooms = ->
  #Session.get('roomListRooms').name
  Rooms.find().fetch()

Template.roomList.avatar  = -> Session.get 'avatar'