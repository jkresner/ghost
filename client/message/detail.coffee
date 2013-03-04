Template.messageDetail.avatarUrl = (userId) ->
  User.findOne(userId).avatar.img

Template.messageDetail.user = ->
  User.findOne({id: this.userId})

