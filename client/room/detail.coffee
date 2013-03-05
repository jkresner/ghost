# TODO: paginate shit

Template.roomDetail.room = -> Session.get 'room'


Template.roomDetail.messages = ->
  if ! Session.get('room')? then return []
  roomId = Session.get('room')._id
  Messages.find roomId: roomId, { sort: { createdAt: -1 } }


placeVote = (elt, value) ->
  elt.parent().find('.voteUp').prop('disabled', false)
  elt.parent().find('.voteDown').prop('disabled', false)
  vote =
    messageId: elt.data('messageid') # Yes, lower case, it's retarded
    userId: getUser()._id
    value: value
    avatarId: Session.get('avatar')._id # TODO: this should be set in the session for persisted avatars
  Meteor.call 'createVote', vote


Template.roomDetail.events =
  'submit #thread-post': (evt) ->
    form = $('#thread-post')
    data = form.serializeObject()
    message =
      roomId: Session.get('roomId')
      text: data.text
      user: Meteor.userId()
      avatar: Session.get('avatar')
    Meteor.call 'createMessage', message
    evt.stopPropagation()
    evt.preventDefault()
    form[0].reset()
    false

  'click .voteUp': (evt) ->
    elt = $(evt.currentTarget)
    placeVote(elt, 1)
    elt.prop('disabled', true)

  'click .voteDown': (evt) ->
    elt = $(evt.currentTarget)
    placeVote(elt, -1)
    elt.prop('disabled', true)

  'click .share a': (evt) ->
    elt = $(evt.currentTarget)
    messageId = elt.data('messageid') # Yes, lower case, it's retarded
    router.navigate 'message/' + messageId
    console.log("OPENING DIALOG")
    # $('#share-dialog').dialog('close')
    $('#share-dialog').dialog
      modal: true
      autoOpen: false
      #position: { my: "top center", at: "top center", of: window }
      #height: $(window).height* 0.9
      #width: $(window).width * 0.6
      #resizable: false
      title: "Where to share?"
      draggable: false
      closeText: "Close"
      #appendTo: "body"
      #$('.ui-dialog').css("top: 0;")
    $('#share-dialog').dialog('open')
