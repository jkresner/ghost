#alert(Modernizr.geolocation);
foundLocation = (location) ->
  console.log location
  Session.set "loc", "lat: " + location.coords.latitude + ", lan: " + location.coords.longitude
noLocation = ->
  alert "no location"
Session.set "loc", "?"

Template.userDetail.location = ->
  output = undefined
  if Modernizr.geolocation
    navigator.geolocation.getCurrentPosition foundLocation, noLocation
    outpout = Session.get("loc")

  Session.get "loc"
