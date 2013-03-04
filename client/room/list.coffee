Template.roomList.Rooms = ->
  Rooms.find().fetch()

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
