# TODO: paginate shit
Template.roomMessages.messages = ->
  Messages.find {}, { sort: { createdAt: -1 } }
