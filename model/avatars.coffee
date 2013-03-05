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

avatars = [
  'av1.png',
  'av10.png',
  'av11.png',
  'av12.png',
  'av13.png',
  'av14.png',
  'av15.png',
  'av16.png',
  'av17.png',
  'av18.png',
  'av19.png',
  'av2.png',
  'av20.png',
  'av21.png',
  'av22.png',
  'av23.png',
  'av24.png',
  'av25.png',
  'av3.png',
  'av4.png',
  'av5.png',
  'av6.png',
  'av7.png',
  'av8.png',
  'av9.png' ]

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
