Template.roomList.rooms = ->
  Rooms.find().fetch()

Template.roomList.avatarName  = ->
  user = Meteor.user()
  getUserAvatar(user).name

Template.roomList.avatarUrl = ->
  user = Meteor.user()
  getUserAvatar(user).name

