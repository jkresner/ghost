geo =
  getGeoLocation: (foundLocCallback, noLocCallback) ->
    if Modernizr.geolocation
      navigator.geolocation.getCurrentPosition(foundLocCallback, noLocCallback, {timeout: 4000})
    else
      noLocCallback()

  # setUserLocation: ->

  # #   cacheNothing = ->
  # #     alert ("You don't share your location with GhostPost? What a DOUCHE MOVE!")
  # #     $log 'User has no GeoLocation. Not setting up Session(userLoc)'

  # #   cacheGeoLocation = (l) ->
  # #     Session.set 'userLoc', [ l.coords.longitude , l.coords.latitude ]
  # #     $log 'Storing Session(userLoc)', Session.get('userLoc')

  # #   geo.getGeoLocation(cacheGeoLocation, cacheNothing)


  distance: (lon1, lat1, lon2, lat2) ->
    radlat1 = Math.PI * lat1 / 180
    radlat2 = Math.PI * lat2 / 180
    radlon1 = Math.PI * lon1 / 180
    radlon2 = Math.PI * lon2 / 180
    theta = lon1 - lon2
    radtheta = Math.PI * theta / 180
    dist = Math.sin(radlat1) * Math.sin(radlat2) + Math.cos(radlat1) * Math.cos(radlat2) * Math.cos(radtheta)
    dist = Math.acos(dist)
    dist = dist * 180 / Math.PI
    dist = dist * 60 * 1.1515
    dist