Template.roomList.events = 
  'submit #thread-post': (evt) ->
    data = $('#thread-post').serializeObject()
    Messages.insert
      text: data.text
      user: Meteor.userId()
      threadid: data.threadId
    evt.stopPropagation()
    evt.preventDefault()
    return false

