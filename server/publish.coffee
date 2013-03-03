Meteor.publish 'rooms', -> Rooms.find({})


# TODO, only publish threads from users rooms
Meteor.publish 'threads', -> Threads.find({})