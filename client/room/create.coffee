Template.roomCreate.error = -> Session.get 'roomCreateError'

Template.roomCreate.events =

  'click button.add': (e, t) ->
    button = $(e.currentTarget)
    button.prop "disabled", true
    data =
      name: t.find("#roomName").value
      ispublic: t.find("#rb_public").checked

    sendCreate = (user_lon, user_lat) ->

      data.lon = user_lon
      data.lat = user_lat

      Meteor.call 'createRoom', data, { wait: false } ,(err, data) ->
        button.prop "disabled", true

        if ! err?
          console.log 'createRoom.success', data.name
          $(t.find("#roomName")).val('')
          Session.set 'room', Rooms.findOne(data._id)
          router.navigate "room/#{data.name}", { trigger: true }
        else
         console.log err

    # foundLocation = (loc) ->
    # sendCreate loc.coords.longitude, loc.coords.latitude
    # geo.getGeoLocation foundLocation, sendCreate, {timeout: 8000}
    sendCreate()
