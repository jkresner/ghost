# id
# user
# name
# img
# created_at

Avatars = new Meteor.Collection 'avatars'

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

isAvatarExpired = (user) ->
  avatar = Avatars.findOne(user.avatarId)
  return true if not avatar
  avatar.date < (new Date()).valueOf() - 24 * 60 * 60 *1000

generateAvatar = (user) -> 
  avatar = 
    date: new Date()
    img:'/avatars/' + Random.choice(avatars)
    name: Random.choice(avatarFirstNames) + Random.choice(avatarLastNames)
    userId: user._id
  id = Avatars.insert avatar
  Session.set('avatar', avatar)

