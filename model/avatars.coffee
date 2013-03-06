# id
# user
# name
# img
# created_at

Avatars = new Meteor.Collection 'avatars'

Avatars.allow
  insert: (userId, avatar) -> true
  update: (userId, avatars, fields, mods) -> true
  remove: (userId, avatar) -> true

# Avatars.allow
#   insert: (userId, avatar) -> false
#   update: (userId, avatars, fields, mods) ->
#     _.all avatars, (a) ->
#       if a.userId? then return false # Already owned
#       allowed = ["userId"]
#       if _.difference(fields, allowed).length then return false # tried to write to forbidden field
#       true
#   remove: (userId, avatar) ->
#     Meteor.users.findOne({id: userId}).admin ? true : false

# commented out because it was taking the app 20 seconds to reload on each change
# fs = __meteor_bootstrap__.require 'fs'
# Meteor.avatarImages =
#  _.map _.reject(fs.readdirSync('public/images/avatars'), (file) -> file == '.DS_Store'), (file) ->
#      '/images/avatars/' + file

avatars = []
for i in [1..25]
  avatars.push "av#{i}.png"

avatarFirstNames = [
  'sexy', 'burnt', 'happy'
]

avatarLastNames = [
  'kitten', 'soap', 'bunny'
]


getValidUserAvatar = (user) ->

  avatar = Session.get 'avatar'
  $log 'getValidUserAvatar', user, avatar

  # if we're anonymous
  if !user? && !avatar? then return generateAvatar null

  # an avatar would have already been assigned
  if user?
    mostrecent_avatar = Avatars.findOne({},{sort:{'createdAt': -1}})
    $log 'mostrecent_avatar', mostrecent_avatar

    if !mostrecent_avatar?
      avatar.userId = user._id
      Avatars.update(avatar)
    else if ! avatarExpired mostrecent_avatar
      avatar = mostrecent_avatar
    else
      avatar = generateAvatar user

  avatar


avatarExpired = (avatar) ->
  if ! avatar? then return true
  avatar.createdAt < ((new Date()).getTime() - 24 * 60 * 60 *1000)


generateAvatar = (user) ->
  data =
    createdAt: (new Date()).getTime()
    img: Random.choice avatars
    name: Random.choice(avatarFirstNames) + Random.choice(avatarLastNames)
    userId: user._id if user?

  data._id = Avatars.insert(data)
  data