# TODO: paginate shit
Template.roomDetail.threads = ->
  threads = Threads.find({roomId: Session.get('roomId')}, {sort: {createdAt: -1}})
  
