geo = {}

getGeoLocation = (user, foundLocationCallback, noLocationCallback) ->
#  foundLocation = (location) ->
#    Session.set('loc','lat: '+location.coords.latitude+', lan: '+ location.coords.longitude)
#  noLocation = ->
#    alert("No location")

  console.log("Modernizr.geolocation", Modernizr.geolocation)
  if Modernizr.geolocation
    navigator.geolocation.getCurrentPosition(foundLocationCallback, noLocationCallback)
