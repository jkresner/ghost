class GhostRouter extends Backbone.Router

  routes:
    "": "roomList"
    "new-room": "roomCreate"
    "room/:roomId": "roomDetail"
    "avatar/:avatarId": "avatarDetail"

  initialize: ->
    setSessionAvatar()

  roomList: () ->
    @showPage 'roomList'

  roomDetail: (roomId) ->  # list of threads
    @showPage 'roomDetail'
    if roomId isnt Session.get("roomId")
      Session.set "roomId", roomId

  roomCreate: () ->
    @showPage 'roomCreate'

  userDetail: (userId) ->  # User page
    @showPage 'userDetail'
    userId = Session.get "userId"
    if oldUser isnt userdId
      Session.set "userId", userId

  # Magic that displays the div with an ID named after the route
  showPage: (pageId) ->
    $log 'Router.'+pageId
    $('.page').hide()
    $('#' + pageId).show()
