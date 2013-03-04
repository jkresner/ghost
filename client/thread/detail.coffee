Template.threadDetail.messages = ->
  console.log @id
  console.log @
  # TODO: pick up here, figure out why we can't see id here
  Messages.find({threadId: @_id}, {sort: {createdAt: -1}})


