
Template.messageDetail.user = ->
  User.findOne({id: this.userId})

