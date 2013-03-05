Template.avatarDetail.avatarExpiration = -> 
  return null if !Session.get('avatar')
  expirationTime = (Session.get('avatar').createdAt + 24*60*60*1000 ) - (new Date()).getTime()
  date = humaneDate(new Date(new Date() - expirationTime))
  date.replace(/// ago///i, '')

Template.avatarDetail.avatar = -> Session.get 'avatar'
