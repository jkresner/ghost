Meteor.publish 'rooms', -> Rooms.find({})

Meteor.publish 'user_avatars', (userId) -> Avatars.find({userId: userId})

Meteor.publish 'room_messages', (roomId) -> Messages.find({roomId: roomId}, {sort: {createdAt: -1}})
