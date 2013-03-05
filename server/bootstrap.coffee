fs = __meteor_bootstrap__.require 'fs'

Meteor.startup ->
  console.log 'ghost server startup'

Meteor.avatars =
  _.map _.reject(fs.readdirSync('public/images/avatars'), (file) -> file == '.DS_Store'), (file) ->
      '/images/' + file

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
