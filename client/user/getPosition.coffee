#alert(Modernizr.geolocation);
foundLocation = (location) ->
  console.log location
  Session.set "loc", "lat: " + location.coords.latitude + ", lan: " + location.coords.longitude
noLocation = ->
  alert "no location"
Session.set "loc", "?"

