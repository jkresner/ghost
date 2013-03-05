# id
# user
# name
# img
# created_at

Avatars = new Meteor.Collection 'avatars'

Avatars.allow
  insert: (userId, msg) ->
    console.log "INSERT"
    console.log userId
    console.log Meteor.userId()
    console.log msg
    if userId == Meteor.userId()
      true
  update: (userId, messages, fieldNames, mods) -> false
  remove: (userId, msgs) ->
    Meteor.users.findOne({id: userId}).admin ? true : false

avatars = [
  'https://fbcdn-profile-a.akamaihd.net/hprofile-ak-snc7/369183_760029419_1091666087_q.jpg',
  'https://fbcdn-profile-a.akamaihd.net/hprofile-ak-ash4/203382_644546930_6239777_q.jpg',
  'https://fbcdn-profile-a.akamaihd.net/hprofile-ak-ash4/369293_717403528_90769369_q.jpg',
  'https://fbcdn-profile-a.akamaihd.net/hprofile-ak-ash4/371736_14900312_1992773374_q.jpg',
  'https://fbcdn-profile-a.akamaihd.net/hprofile-ak-ash4/371812_7941262_2097571294_q.jpg'
]

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
    img: Random.choice(avatars)
    name: Random.choice(avatarFirstNames) + Random.choice(avatarLastNames)
    userId: user._id if user?
  id = Avatars.insert avatar
  avatar

