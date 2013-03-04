# TODO: paginate shit

Template.roomDetail.info = ->
  Session.get('roomId')

Template.roomDetail.threads = ->
  threads = Threads.find({roomId: Session.get('roomId')}, {sort: {createdAt: -1}})
  
