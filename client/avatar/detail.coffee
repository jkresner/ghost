Template.roomList.avatarName  = ->
  user = Meteor.user
  if isAvatarExpired(user)
    generateAvatar(user)
  Session.get('avatar').name

Template.roomList.avatarUrl = ->
  user = Meteor.user
  if isAvatarExpired(user)
    generateAvatar(user)
  Session.get('avatar').img

