# TODO: paginate shit

Template.roomDetail.info = ->
  Session.get('roomId')

Template.roomDetail.messages = ->
  if not Session.get('roomId')
    return []
  msgs = Messages.find({roomId: Session.get('roomId')}, {sort: {createdAt: -1}})
  msgs

Template.roomDetail.events = 
  'submit #thread-post': (evt) ->
    form = $('#thread-post')
    data = form.serializeObject()
    message = 
      roomId: Session.get('roomId')
      text: data.text
      user: Meteor.userId()
    Meteor.call 'createMessage', message
    evt.stopPropagation()
    evt.preventDefault()
    form[0].reset()
    return false

  
