Template.roomCreate.error = -> Session.get 'roomCreateError'



Template.roomCreate.events =
  'click button.add': (e, t) ->
    data =
      name: t.find("#roomName").value
      ispublic: t.find("#rb_public").checked

    sendCreate = (user_long, user_lat) ->
      data.long = user_long
      data.lat = user_lat
      $log 'sendingCreateRoom', data

      Meteor.call 'createRoom', data, (err, data) ->
        console.log("send create")
        if ! err? then console.log('createRoom.success',data) else console.log(err)
        router.navigate "room/#{data}", { trigger: true }
        $(t.find("#roomName")).val('')

    foundLocation = (loc) ->
      sendCreate loc.coords.longitude, loc.coords.latitude

    geo.getGeoLocation foundLocation, sendCreate, {timeout: 8000}
