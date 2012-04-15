chrome.extension.onRequest.addListener (request, sender, callback)->
    if request.action == 'notification'
        notification(request.image, request.title, request.message)

notification = (image, title, message)->
    notification = window.webkitNotifications.createNotification(image, title, message)
    notification.show()