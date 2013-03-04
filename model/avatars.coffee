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
  '281924_10102908302685040_489444674_a.jpg',
  '423057_10151396577010982_357290209_s.jpg',
  '540794_10102404993610343_1957767826_n.jpg'
]

avatarFirstNames = [
  'sexy'
]

avatarLastNames = [
  'kitten'
]

getUserAvatar = (user) ->
  if isAvatarExpired(user)
    generateAvatar(user)
  Session.get('avatar')

isAvatarExpired = (user) ->
  avatar = Session.get('avatar')
  if not avatar
    avatar = Avatars.findOne({userId: user._id}, {sort: {created_at: -1}})
    return true if not avatar
  Session.set('avatar', avatar)
  avatar.date < (new Date()).valueOf() - 24 * 60 * 60 *1000

generateAvatar = (user) -> 
  avatar = 
    date: new Date()
    img:'/avatars/' + Random.choice(avatars)
    name: Random.choice(avatarFirstNames) + Random.choice(avatarLastNames)
    userId: user._id
  id = Avatars.insert avatar
  Session.set('avatar', avatar)

