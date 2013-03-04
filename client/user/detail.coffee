Template.userDetail.status = ->

  usr = Meteor.user()
  if usr?
    status = "Connected as <img src='http://graph.facebook.com/#{usr.profile.facebook.id}/picture/'> " + usr.profile.facebook.name
  else
    status = "Not connected"



