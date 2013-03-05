Template.roomCreate.error = -> Session.get 'roomCreateError'

Template.roomCreate.events =
  'click input.add': (e, t) ->
    input = $(t.find("#roomCreateName"))


    foundLocation = (location) ->
      console.log("Room " + input.val() + " created at long:"+ location.coords.longitude + " / lat:" + location.coords.latitude)
      sendCreate location.coords.longitude, location.coords.latitude
    noLocation = ->
      console.log("Room " + input.val() + " created without location")
      sendCreate '', ''

    getGeoLocation(Meteor.user, foundLocation, noLocation)

    sendCreate = (user_long, user_lat) ->
      data =
        name: input.val()
        ispublic: true
        long: user_long
        lat: user_lat

      input.val('')

      Meteor.call 'createRoom', data, (err, data) ->
        if ! err? then console.log(data) else console.log(err)
        router.navigate('rooms/' + data, false)
