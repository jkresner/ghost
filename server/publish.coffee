Meteor.publish 'rooms', -> Rooms.find({})

Meteor.publish 'user_avatars', (userId) -> Avatars.find({userId: userId})

Meteor.publish 'room_threads', (roomId) -> Messages.find({roomId: roomId}, {sort: {createdAt: -1}})

Meteor.publish 'messages', -> Messages.find({})

# TODO, only publish threads from users rooms
Meteor.publish 'threads', -> Threads.find({})
