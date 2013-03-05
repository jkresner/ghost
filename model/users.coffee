# id
# name
# avatar
# real_name
# email
# created_at

# Retrieve the current user or temporary anonymous user id
getUser = ->
  Meteor.user() # or $.cookie.get('anon_user') # This cookie shit doesn't work yet


getGeoLocation = (user, foundLocationCallback, noLocationCallback) ->
#  foundLocation = (location) ->
#    Session.set('loc','lat: '+location.coords.latitude+', lan: '+ location.coords.longitude)
#  noLocation = ->
#    alert("No location")

  console.log("Modernizr.geolocation", Modernizr.geolocation)
  if Modernizr.geolocation
    navigator.geolocation.getCurrentPosition(foundLocationCallback, noLocationCallback)
