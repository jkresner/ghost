class GhostRouter extends Backbone.Router
  routes: 
    "": "roomList"
    "rooms:roomId": "roomDetail"
    "rooms/create": "roomCreate"
    "threads:threadId": "threadDetail"
    "threads/create": "threadCreate"
    "user:userId": "userDetail"
    "rooms/create": "roomCreate"

  # Magic that displays the div with an ID named after the route
  initialize: () -> 
    $log '@ ', @
    # TODO: this should only iterate own properties, route functions shouldn't be on prototype
    debugger
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

  roomDetail: (roomId) ->  # list of threads
    oldRoom = Session.get "roomId"
    if oldList isnt roomId
      Session.set "roomId", roomId
  roomCreate: () -> 
    Session.set "view", 'roomCreate'
  threadDetail: (threadid) ->  # list of messages
    threadId = Session.get "threadId"
    if oldThread isnt threadId
      Session.set "threadId", threadId
    showPage()
  userDetail: (userId) ->  # User page
    userId = Session.get "userId"
    if oldUser isnt userdId
      Session.set "userId", userId

router = new GhostRouter()


Meteor.startup ->
  Backbone.history.start({pushState: true});

