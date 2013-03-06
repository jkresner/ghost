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
      console.log 'required text param missing', d
      throw new Meteor.Error 400, 'Required parameter missing'

    if d.text.length > 200 then throw new Meteor.Error 413, "Text too long"

    # if !@userId then throw new Meteor.Error 403, "You must be logged in"

    if ! d.roomId?
      throw new Meteor.Error 403, "You must post message to a room"

    #data.userId = @userId
    #user = Meteor.users.findOne(@userId)
    data.createdAt = (new Date).getTime()
    id = Messages.insert data
    if id
      data._id = id
      console.log('updating room ' + data.roomId)
      console.log(data)
      room = Rooms.findOne({name: data.roomId })
      console.log(room)
      ret = Rooms.update({name: data.roomId }, {$set: {latestMessage: data}})
      console.log(ret)
    data
