fs = __meteor_bootstrap__.require 'fs'

Meteor.startup ->
  console.log "
      .-.   .-.   .-.     .--.                         |          S T P O S T\n
     | OO| | OO| | OO|   / _.-' .-.   .-.  .-.   .''.  |        O S T P O S T\n
     |   | |   | |   |   \\  '-. '-'   '-'  '-'   '..'  |      H O S T P O S T\n
     '^^^' '^^^' '^^^'    '--'                         |    G H O S T P O S T . i o\n"

Meteor.avatarImages =
  _.map _.reject(fs.readdirSync('public/images/avatars'), (file) -> file == '.DS_Store'), (file) ->
      '/images/avatars/' + file

Meteor.methods
  getAvatarImages: ->
    Meteor.avatarImages

Rooms._ensureIndex({ loc : "2d" });

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
