class GhostRouter extends Backbone.Router

  routes:
    "": "roomList"
    "new-room": "roomCreate"
    "rooms/:roomId": "roomDetail"
    "threads/:threadId": "threadDetail"
    "threads/create": "threadCreate"
    "avatar/:avatarId": "avatarDetail"
    "rooms/create": "roomCreate"

  # Magic that displays the div with an ID named after the route
  initialize: ->
    $log 'Router.init:', @
    # TODO: this should only iterate own properties, route functions shouldn't be on prototype
    null

  roomList: () ->
    @showPage 'roomList'

  roomDetail: (roomId) ->  # list of threads
    @showPage 'roomDetail'
    oldRoom = Session.get "roomId"
    if oldRoom isnt roomId
      Session.set "roomId", roomId

  roomCreate: () ->
    @showPage 'roomCreate'

  userDetail: (userId) ->  # User page
    @showPage 'userDetail'
    userId = Session.get "userId"
    if oldUser isnt userdId
      Session.set "userId", userId

  showPage: (pageId) ->
    $log 'Router.'+pageId
    $('.page').hide()
    $('#' + pageId).show()
