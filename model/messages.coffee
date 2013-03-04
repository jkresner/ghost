# id
# user_id: user id
# thread_id: room id
# text
# created_at

Messages = new Meteor.Collection 'messages'

Messages.allow
  insert: (userId, msg) -> 
    room = Session.get('roomId')
    console.log Session
    console.log Session.get('roomId')
    if not room
      return false
    msg.created_at = new Date
    if msg.thread is undefined
      thread = Threads.insert({created_at: new Date, startingUser: userId, roomId: room})
      msg.threadId = thread.id
    console.log room, msg.thread, msg.thread.roomId
    if room == msg.thread.roomId
      true
  update: (userId, messages, fieldNames, mods) -> false
  remove: (userId, msgs) -> 
    Users.findOne({id: userId}).admin ? true : false


