#Rooms.remove({})
#Messages.remove({})
#mongo = __meteor_bootstrap__.require 'mongoose'

Meteor.startup ->
  console.log "
      .-.   .-.   .-.     .--.                         |          S T P O S T\n
     | OO| | OO| | OO|   / _.-' .-.   .-.  .-.   .''.  |        O S T P O S T\n
     |   | |   | |   |   \\  '-. '-'   '-'  '-'   '..'  |      H O S T P O S T\n
     '^^^' '^^^' '^^^'    '--'                         |    G H O S T P O S T . i o\n"
# Dev application

Accounts.onCreateUser (options, user) ->
  if options.profile # maintain the default behavior
    user.profile = options.profile

  # get profile data from Facebook
  result = Meteor.http.get "https://graph.facebook.com/me", {
      params: { access_token: user.services.facebook.accessToken } }

  if !result.error && result.data
    # if successfully obtained facebook profile, save it off
    user.profile.facebook = result.data

  user
