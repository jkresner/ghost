Template.threadDetail.messages = ->
  Messages.find({threadId: @id}, {sort: {createdAt: -1}})


