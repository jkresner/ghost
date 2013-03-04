# TODO: paginate shit

Template.roomDetail.info = ->
  Session.get('roomId')

Template.roomDetail.threads = ->
  threads = Threads.find({})
  console.log threads
  threads

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

  
