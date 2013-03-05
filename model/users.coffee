# id
# name
# avatar
# real_name
# email
# created_at

# Retrieve the current user or temporary anonymous user id
getUser = ->
  Meteor.user() # or {_id: $.cookie.get('anon_user')} # This cookie shit doesn't work yet
getUserId = ->
  Meteor.userId() # or $.cookie.get('anon_user') # This cookie shit doesn't work yet