# owner: user id
# name: String
# description: String
# ispublic: Boolean
# created_at

Rooms = new Meteor.Collection 'rooms'

Rooms.allow
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
  createRoom: (data) ->
    d = data || {}

    if (! (typeof d.name is "string" && d.name.length) )

      console.log 'required param missing'
      throw new Meteor.Error 400, 'Required parameter missing'

    if d.name.length > 100 then throw new Meteor.Error 413, "Name too long"
    if !@userId then throw new Meteor.Error 403, "You must be logged in"

    Room.insert
      owner: @userId
      name: d.name,
      description: d.description
      ispublic: !! d.ispublic
      start: d.start
      end: d.end
