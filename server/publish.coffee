Meteor.publish 'rooms', -> Rooms.find({})

Meteor.publish 'messages', -> Messages.find({})

# TODO, only publish threads from users rooms
Meteor.publish 'threads', -> Threads.find({})
