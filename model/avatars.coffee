# id
# user
# name
# img
# created_at

Avatars = new Meteor.Collection 'avatars'

Avatars.allow
  insert: (userId, avatar) -> false
  update: (userId, avatars, fields, mods) ->
    _.all avatars, (a) ->
      debugger
      if a.userId? then return false # Already owned
      allowed = ["userId"]
      if _.difference(fields, allowed).length then return false # tried to write to forbidden field
      true

  remove: (userId, avatar) ->
    Meteor.users.findOne({id: userId}).admin ? true : false

# commented out because it was taking the app 20 seconds to reload on each change
# fs = __meteor_bootstrap__.require 'fs'
# Meteor.avatarImages =
#  _.map _.reject(fs.readdirSync('public/images/avatars'), (file) -> file == '.DS_Store'), (file) ->
#      '/images/avatars/' + file

Meteor.methods
  createAvatar: (data) ->
    data.createdAt = (new Date).getTime()
    Avatars.insert data


avatars = []
for i in [1..25]
  avatars.push "av#{i}.png"

avatarFirstNames = [
  'sexy', 'burnt', 'happy'
]

avatarLastNames = [
  'kitten', 'soap', 'bunny'
]

setSessionAvatar = ->
  avatar = Session.get 'avatar'
  user = Meteor.user()

  if ! avatar? && user?
    mostrecent_avatar = Avatars.findOne({userId: user._id}, {sort: {created_at: -1}})
    if ! avatarExpired mostrecent_avatar
      avatar = mostrecent_avatar

  if !avatar? || ! avatarExpired avatar
    avatar = generateAvatar user

  avatar

avatarExpired = (avatar) ->
  return true if ! avatar?
  avatar.createdAt < ((new Date()).getTime() - 24 * 60 * 60 *1000)

generateAvatar = (user) ->
  avatar =
    createdAt: (new Date()).getTime()
    img: Random.choice avatars # TODO: FIX THIS Session.get('avatar_images')
    name: Random.choice(avatarFirstNames) + Random.choice(avatarLastNames)
    userId: user._id if user?
  Meteor.call 'createAvatar', avatar, (err, d) ->
    avatar._id = d
    debugger
    Session.set 'avatar', avatar
  avatar
