path = __meteor_bootstrap__.require('path')
MongoDB = __meteor_bootstrap__.require('mongodb')
Future = __meteor_bootstrap__.require(path.join('fibers', 'future'))

addAggregateSupport = (collection) ->
  collection.aggregate = (pipeline) ->
    self = @

    future = new Future();
    self.find()._mongo.db.createCollection self._name, (err, collection) ->
      if err?
        future.throw(err);
        return;
      collection.aggregate pipeline, (err, result) ->
        if err?
          future.throw(err);
          return;
        future.ret([true, result]);
    result = future.wait();
    if !result[0]
      throw result[1];

    return result[1];
_.each [Messages, Votes], (obj) -> 
  addAggregateSupport(obj)

# Periodically update room scores
updateRoomScores = ->
  console.log('wut')
  roomMessageCounts = Messages.aggregate [
    {$group: {_id: "$roomId", count: {$sum: 1}}}, 
    {$sort: {roomId: 1}}, 
    {$match: {createdAt: {$gt: (new Date()).getTime() - 60*1000}}}]
  roomVoteCounts = Votes.aggregate [
    {$group: {_id: "$roomId", count: {$sum: 1}}}, 
    {$sort: {roomId: 1}}, 
    {$match: {createdAt: {$gt: (new Date()).getTime() - 60*1000}}}]

  rooms = []
  i = messageIndex = voteIndex = 0
  count = Math.max roomMessageCounts.count, roomVoteCounts.count
  while(i < count)
    console.log('blah')
    msgCount = roomMessageCounts[messageIndex]
    voteCount = roomVoteCounts[voteIndex]
    if msgCount.roomId == voteCount.roomId
      rooms.push({roomId: msgCount.roomId, count: msgCount.count})
    else if msgCount.roomId < voteCount.roomId
      rooms.push msgCount
      messageIndex++
    else
      rooms.push voteCount
      voteIndex++
    i++
  _.each rooms, (room) ->
    Rooms.update({_id: room.roomId}, {score: room.count})
  console.log(rooms)


setInterval updateRoomScores, 10 * 60 * 1000 # Update room scores every 10 minutes
updateRoomScores()
