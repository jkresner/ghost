# userId: user id
# messageId: message id
# value: -1 / +1
# created_at

Votes = new Meteor.Collection 'votes'

Votes.allow
  insert: (userId, room) -> false # // no cowboy inserts -- use createRoom method
  update: (userId, rooms, fields, modifier) ->
    _.all rooms, (r) ->

      if userId isnt r.owner then return false # not the owner

      allowed = ["name", "description"]

      if _.difference(fields, allowed).length then return false # tried to write to forbidden field

      true

  remove: (userId, roomss) ->
    # deny if not the owner
    ! _.any rooms, (h) -> h.owner isnt userId


Meteor.methods
  createVote: (data) ->
    d = data || {}

    # Check if already voted and replace it

    Rooms.insert
      #owner: @userId # took out owner as that is not part of the current design
      name: d.name
      ispublic: !! d.ispublic
      loc: [d.long, d.lat]
      # start: d.start
      # end: d.end

