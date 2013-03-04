Template.roomCreate.error = -> Session.get 'roomCreateError'

Template.roomCreate.events =
  'click input.add': (e, t) ->
    data =
      name: t.find("#roomCreateName").value
      ispublic: true

    Meteor.call 'createRoom', data, (err, data) ->
      if ! err? then console.log(data) else console.log(err)




