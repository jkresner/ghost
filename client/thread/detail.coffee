Template.threadDetail.messages = ->
  threads = Messages.find({threadId: Session.get('roomId')}, {sort: {createdAt: -1}})

