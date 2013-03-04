<<<<<<< HEAD



=======
# TODO: unused?
>>>>>>> d589afd99938b76dee14495ce11cc564116d4486
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

