# id
# user
# name
# img
# created_at

Avatars = new Meteor.Collection 'avatars'

Avatars.allow
  insert: (userId, msg) ->
    if userId == Meteor.userId()
      true
  update: (userId, messages, fieldNames, mods) -> false
  remove: (userId, msgs) ->
    Meteor.users.findOne({id: userId}).admin ? true : false

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

setSessionAvatar = ->
  avatar = Session.get 'avatar'
  user = Meteor.user()

  if ! avatar? && user?
    mostrecent_avatar = Avatars.findOne({userId: user._id}, {sort: {created_at: -1}})
    if ! avatarExpired mostrecent_avatar
      avatar = mostrecent_avatar
      Session.set 'avatar', avatar

  if !avatar? || ! avatarExpired avatar
    avatar = generateAvatar user
    Session.set 'avatar', avatar

  avatar

avatarExpired = (avatar) ->
  avatar.date < ((new Date()).valueOf() - 24 * 60 * 60 *1000)

generateAvatar = (user) ->
  avatar =
    date: new Date()
    img: Random.choice avatars # TODO: FIX THIS Session.get('avatar_images')
    name: Random.choice(avatarFirstNames) + Random.choice(avatarLastNames)
    userId: user._id if user?
  id = Avatars.insert avatar
  avatar
