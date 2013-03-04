Template.messageDetail.avatarUrl = () ->
  $log "FUCK"
  $log @userId
  getUserAvatar(Meteor.users.findOne(@userId)).img

Template.messageDetail.user = ->
  Meteor.users.findOne({id: @userId})

