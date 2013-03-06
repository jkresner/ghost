permissions = ['email', 'user_events', 'user_groups', 'read_friendlists', 'publish_actions', ]
Accounts.ui.config
  requestPermissions:
    facebook: permissions

Meteor.loginWithFacebook  = _.wrap Meteor.loginWithFacebook, (login, opts, callback) ->
  newCallback = ->
    callback()
    # Set session avatar
    avatar = Session.get('avatar')
    debugger
    if ! avatar.userId?
      up = Meteor.call 'updateAvatar', avatar._id, {userId: Meteor.userId()}, (err, d) ->
        Session.set('avatar', d)
        window.history.back()
        window.history.back()
  login(opts, newCallback)


Meteor.startup ->
  #geo.setUserLocation()

  $ ->
    window.router = new GhostRouter()
    Backbone.history.start pushState: false


Template.setup.created = ->
  $log 'adding google analytics'
  # window._gaq = _gaq || [];
  # _gaq.push(['_setAccount', 'UA-38990344-1'])
  # _gaq.push(['_setDomainName', 'ghostpost.io'])
  # _gaq.push(['_trackPageview'])

  # (->
  #   ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
  #   gajs = '.google-analytics.com/ga.js'
  #   ga.src = if document.location.protocol is 'https:' then 'https://ssl'+gajs else 'https://www'+gajs
  #   s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s)
  # )()
