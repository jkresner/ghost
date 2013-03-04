# TODO: paginate shit

Template.roomDetail.info = ->
  Session.get('roomId')

Template.roomDetail.threads = ->
  Threads.find({roomId: Session.get('roomId')}, {sort: {createdAt: -1}})

Template.roomDetail.events = 
  'submit #thread-post': (evt) ->
    data = $('#thread-post').serializeObject()
    message = 
      roomId: Session.get('roomId')
      text: data.text
      user: Meteor.userId()
      threadId: data.threadId
    Meteor.call 'createMessage', message
    evt.stopPropagation()
    evt.preventDefault()
    return false

  
