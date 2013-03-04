# TODO: paginate shit

Template.roomDetail.info = ->
  Session.get('roomId')

Template.roomDetail.threads = ->
  threads = Threads.find({roomId: Session.get('roomId')}, {sort: {createdAt: -1}})
  console.log threads
  threads

Template.roomDetail.events = 
  'submit #thread-post': (evt) ->
    data = $('#thread-post').serializeObject()
    debugger
    message = 
      roomId: Session.get('roomId')
      text: data.text
      user: Meteor.userId()
      threadid: data.threadId
    Meteor.call 'createMessage', message
    evt.stopPropagation()
    evt.preventDefault()
    return false

  
