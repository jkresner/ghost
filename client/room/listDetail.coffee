
Template.roomListDetail.latestMessageTime = ->
  if @latestMessage
    humaneDate new Date(@latestMessage.createdAt)
  else
    "No messages yet"


