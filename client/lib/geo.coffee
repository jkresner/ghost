geo =
  getGeoLocation: (foundLocCallback, noLocCallback) ->
    if Modernizr.geolocation
      navigator.geolocation.getCurrentPosition foundLocCallback, noLocCallback