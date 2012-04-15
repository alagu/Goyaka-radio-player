fetch_feeds =->
    feeds = jQuery('.fbGroupsStream li.uiUnifiedStory')
    
    for feed in feeds
        link = jQuery(feed).find('.uiAttachmentTitle a')
        if link.length > 0
            song = $(link[0])
            console.log(song.html() + ' ' + song.attr('href')) 
    
$(document).ready ->
    fetch_feeds()