Template.userDetail.status = ->

  if userId = Metero.user().id
    console.log("You are looking at your own profile")
  else
    console.log("Looking at someone else's profile")


  usr = Meteor.user()
  if usr?
    status = "Connected as <img src='http://graph.facebook.com/#{usr.profile.facebook.id}/picture/'> " + usr.profile.facebook.name
  else
    status = "Not connected"



