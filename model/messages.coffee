# id
# user_id: user id
# text
# score
# createdAt

Messages = new Meteor.Collection 'messages'

Messages.allow
  insert: (userId, msg) -> false
  update: (userId, messages, fieldNames, mods) -> false
  remove: (userId, msgs) -> 
    Meteor.users.findOne({id: userId}).admin ? true : false


Meteor.methods
  createMessage: (data) ->
    d = data || {}

    if (! (typeof d.text is "string" && d.text.length) )
      console.log 'required param missing'
      throw new Meteor.Error 400, 'Required parameter missing'

    if d.text.length > 200 then throw new Meteor.Error 413, "Text too long"

    if !@userId then throw new Meteor.Error 403, "You must be logged in"

    if not data.roomId
      throw new Meteor.Error 403, "You must be logged in"

    data.userId = @userId
    user = Meteor.users.findOne(@userId)
    data.createdAt = (new Date).getTime()
    Messages.insert data
