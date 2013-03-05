# TODO: paginate shit

Template.roomDetail.room = -> Session.get 'room'


Template.roomDetail.messages = ->
  Messages.find {}, { sort: { createdAt: -1 } }


Template.roomDetail.distanceFromUser = ->
  roomLoc = @loc
  userLoc = Session.get('userLoc')
  $log 'roomLoc', roomLoc, '@loc', @loc

  if roomLoc
    if Session.get('userLoc')
      $log 'Distance of room ', @name , ' from user: ', Math.round( distance( roomLoc[0], roomLoc[1], userLoc[0], userLoc[1] ) *100 ) / 100 + " mi away - "
      ( Math.round( distance( roomLoc[0], roomLoc[1], userLoc[0], userLoc[1] ) *100 ) / 100 ) + " mi away - "


placeVote = (elt, value) ->
  elt.parent().find('.voteUp').prop('disabled', false)
  elt.parent().find('.voteDown').prop('disabled', false)
  vote =
    messageId: elt.data('messageid') # Yes, lower case, it's retarded
    userId: getUserId()
    value: value
    avatarId: Session.get('avatar')._id # TODO: this should be set in the session for persisted avatars
  Meteor.call 'createVote', vote

Template.roomDetail.events =
  'click #postMessage': (e, t) ->

    data =
      roomId: Session.get('roomId')
      text: t.find('#postText').value
      avatar: Session.get('avatar')

    Meteor.call 'createMessage', data, (err, data) ->
      if ! Meteor.user()?
        Session.set('flash', "Your message posted successfully.")
        redirectFn = -> router.navigate('me', {trigger: true})
        setTimeout redirectFn, 2000

  'click .voteUp': (e) ->
    elt = $(e.currentTarget)
    placeVote(elt, 1)
    elt.prop('disabled', true)

  'click .voteDown': (e) ->
    elt = $(e.currentTarget)
    placeVote(elt, -1)
    elt.prop('disabled', true)

  'click .share': (evt) ->
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
