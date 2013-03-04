class GhostRouter extends Backbone.Router

  routes:
    "": "roomList"
    "rooms/:roomId": "roomDetail"
    "rooms/create": "roomCreate"
    "threads/:threadId": "threadDetail"
    "threads/create": "threadCreate"
    "user/:userId": "userDetail"
    "rooms/create": "roomCreate"

  # Magic that displays the div with an ID named after the route
  initialize: ->
    $log 'Router.init:', @

  roomList: () ->
    @showPage 'roomList'

  roomDetail: (roomId) ->  # list of threads
    @showPage 'roomDetail'
    oldRoom = Session.get "roomId"
    if oldRoom isnt roomId
      Session.set "roomId", roomId

  roomCreate: () ->
    @showPage 'roomCreate'
    Session.set "view", 'roomCreate'

  threadDetail: (threadId) ->  # list of messages
    @showPage 'threadDetail'
    oldThread = Session.get "threadId"
    if oldThread isnt threadId
      Session.set "threadId", threadId
    showPage()

  userDetail: (userId) ->  # User page
    @showPage 'userDetail'
    userId = Session.get "userId"
    if oldUser isnt userdId
      Session.set "userId", userId

  showPage: (pageId) ->
    $log 'Router.'+pageId
    $('.page').hide()
    $('#' + pageId).show()
