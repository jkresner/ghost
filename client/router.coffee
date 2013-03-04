class GhostRouter extends Backbone.Router

  routes:
    "": "roomList"
    "new-room": "roomCreate"
    "rooms/:roomId": "roomDetail"
    "threads/:threadId": "threadDetail"
    "threads/create": "threadCreate"
    "user/:userId": "userDetail"
    "rooms/create": "roomCreate"

  # Magic that displays the div with an ID named after the route
  initialize: ->
    $log 'Router.init:', @
    # TODO: this should only iterate own properties, route functions shouldn't be on prototype
    for own attr, val of @
      $log 'attr: ', attr, ' val: ', val
      if typeof @[attr] == 'function'
        @[attr] = _.wrap (fn, args) ->
          $log '@,', @
          $('.page').hide()
          $('#' + attr).show()
          fn.call @, args
    null

  roomList: () ->
    @showPage 'roomList'

  roomDetail: (roomId) ->  # list of threads
    @showPage 'roomDetail'
    oldRoom = Session.get "roomId"
    if oldRoom isnt roomId
      Session.set "roomId", roomId

  roomCreate: () ->
    console.log("roomCreate called")
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
