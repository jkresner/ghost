class GhostRouter extends Backbone.Router

  routes:
    "": "roomList"
    "me": "userDetail"
    "new-room": "roomCreate"
    "room/:roomId": "roomDetail"
    "message/:messageId": "messageDetail"
    "avatar/:avatarId": "avatarDetail"

  initialize: ->
    console.log 'Router.init'
    Session.set 'avatar', getValidUserAvatar(null)

  roomList: () ->
    @showPage 'roomList'

  roomDetail: (name) ->  # list of threads
    show = @showPage
    Meteor.call 'createRoom', {name: name}, (err, d) ->
      show 'roomDetail'
      if d.name isnt Session.get("roomId")
        $log 'roomDetail.settingSession', name
        Session.set "roomId", name

  roomCreate: () ->
    @showPage 'roomCreate'

  userDetail: () ->
    @showPage 'userDetail'

  avatarDetail: (avatarId) ->  # User page
    @showPage 'avatarDetail'
    oldAvatarId= Session.get "avatarId"
    if oldAvatarId isnt avatarId
      Session.set "avatarId", avatarId

  messageDetail: (messageId) ->
    @showPage 'messageDetail'
    if messageId isnt Session.get("messageId")
      $log 'messageDetail.settingSession', messageId
      Session.set "messageId", messageId

  # Magic that displays the div with an ID named after the route
  showPage: (pageId) ->
    $log 'Router.'+pageId
    $('.page').hide()
    $('#' + pageId).show()
