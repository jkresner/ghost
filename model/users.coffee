# id
# name
# avatar
# real_name
# email
# created_at
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
  user.avatar = user.avatar or {}
  return true if not user.avatar.date
  user.avatar.date < (new Date()).valueOf() - 24 * 60 * 60 *1000

generateAvatar = (user) -> 
  user.avatar = user.avatar or {}
  user.avatar.date = new Date()
  user.avatar.img = '/avatars/' + Random.choice(avatars)
  user.avatar.name = Random.choice(avatarFirstNames) + Random.choice(avatarLastNames)
  console.log(user)
  Meteor.users.update(user)
