# id
# user_id: user id
# thread_id: room id
# text
# created_at

Messages = new Meteor.Collection 'messages'

Messages.allow
  insert: (userId, msg) -> false
  update: (userId, messages, fieldNames, mods) -> false
  remove: (userId, msgs) -> 
    Meteor.users.findOne({id: userId}).admin ? true : false


Meteor.methods
  createMessage: (data) ->
    console.log data
    d = data || {}

    if (! (typeof d.text is "string" && d.text.length) )
      console.log 'required param missing'
      throw new Meteor.Error 400, 'Required parameter missing'

    console.log data
    if d.text.length > 200 then throw new Meteor.Error 413, "Text too long"

    if !@userId then throw new Meteor.Error 403, "You must be logged in"

    if not data.roomId
      throw new Meteor.Error 403, "You must be logged in"

    data.userId = @userId
    data.created_at = new Date
    thread = null
    if data.thread is undefined
      id = Threads.insert
        created_at: new Date()
        startingUser: @userId
        roomId: data.roomId
      data.threadId = id
    thread = Threads.findOne data.threadId
    data.threadId = thread._id
    if data.roomId == thread.roomId
      console.log "INSERTING"
      console.log data
      Messages.insert data
