Template.messageDetail.avatarUrl = () ->
  @avatar && @avatar.img

Template.messageDetail.user = ->
  Meteor.users.findOne({id: @userId})

