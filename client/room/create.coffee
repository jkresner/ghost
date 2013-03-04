Template.roomCreate.error = -> Session.get 'roomCreateError'

Template.roomCreate.events =
  'click input.add': (e, t) ->
    input = $(t.find("#roomCreateName"))
    data =
      name: input.val()
      ispublic: true
    input.val('')

    Meteor.call 'createRoom', data, (err, data) ->
      if ! err? then console.log(data) else console.log(err)
      router.navigate 'rooms/' + data, false




