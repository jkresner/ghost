class GhostRouter extends Backbone.Router

  routes:
    "": "roomList"
    "new-room": "roomCreate"
    "room/:roomId": "roomDetail"
    "messages/:messageId": "messageDetail"
    "avatar/:avatarId": "avatarDetail"

  initialize: ->
    setSessionAvatar()

  roomList: () ->
    @showPage 'roomList'

  roomDetail: (roomId) ->  # list of threads
    @showPage 'roomDetail'
    oldRoom = Session.get "roomId"
    if oldRoom isnt roomId
      Session.set "roomId", roomId

  roomCreate: () ->
    @showPage 'roomCreate'

  avatarDetail: (avatarId) ->  # User page
    @showPage 'avatarDetail'
    oldAvatarId= Session.get "avatarId"
    if oldAvatarId isnt avatarId
      Session.set "avatarId", avatarId

  messageDetail: () ->
    @showPage 'messageDetail'
    userId = Session.get "userId"
    if oldUser isnt userdId
      Session.set "userId", userId

  # Magic that displays the div with an ID named after the route
  showPage: (pageId) ->
    $log 'Router.'+pageId
    $('.page').hide()
    $('#' + pageId).show()
