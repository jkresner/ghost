# userId: user id
# messageId: message id
# value: -1 / +1
# createdAt

Votes = new Meteor.Collection 'votes'

Votes.allow
  insert: (userId, room) -> false # // no cowboy inserts -- use createRoom method
  update: (userId, rooms, fields, modifier) ->
    _.all votes, (v) ->

      if userId isnt v.userId then return false # not the owner
      if d.value > 1 or d.value < -1 then return false

      true

  remove: (userId, roomss) ->
    # deny if not the owner
    ! _.any rooms, (h) -> h.owner isnt userId


Meteor.methods
  createVote: (data) ->
    d = data || {}

    if d.value > 1 or d.value < -1 then throw new Meteor.Error 403, "Votes must be <= 1"

    # Check if already voted and replace it
    conditions = {messageId: data.messageId, userId: data.userId}
    message = Messages.findOne(data.messageId)
    score = message.score || 0
    data.roomId = message.roomId
    data.createdAt = (new Date()).getTime()
    vote = Votes.findOne(conditions)
    if vote
      Votes.update(conditions, data)
      score -= vote.value
    else
      vote = Votes.insert data
    score += d.value
    message = _.extend(message, {score: score})
    Messages.update({_id: message._id}, message)
    vote
