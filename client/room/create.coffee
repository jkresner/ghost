Template.roomCreate.error = -> Session.get 'roomCreateError'

Template.roomCreate.events =
  'click input.add': (e, t) ->
    input = $(t.find("#roomCreateName"))

    foundLocation = (location) ->
      console.log("Room " + input.val() + " created at long:"+ location.coords.longitude + " / lat:" + location.coords.latitude)
      data =
        name: input.val()
        ispublic: true
        long: location.coords.longitude
        lat: location.coords.latitude

    noLocation = ->
      console.log("Room " + input.val() + " created without location")
      data =
        name: input.val()
        ispublic: true

    getGeoLocation(Meteor.user, foundLocation, noLocation)

    input.val('')

    Meteor.call 'createRoom', data, (err, data) ->
      if ! err? then console.log(data) else console.log(err)
      router.navigate('rooms/' + data)




