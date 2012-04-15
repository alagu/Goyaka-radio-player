fetch_feeds =->
    feeds = jQuery('.fbGroupsStream li.uiUnifiedStory')
    i = 1
    for feed in feeds
        link = jQuery(feed).find('.uiAttachmentTitle a')
        if link.length > 0
            song = $(link[0])
            console.log(i + ' ' + song.html() + ' ' + song.attr('href')) 
            i++
    
    console.log(feeds.length)

add_player_box =->
    player_wrap = jQuery('<div style="width:100px;height:200px;position:absolute;top:0;left:50%;background-color:#ff0;">Hello!</div>')    
    jQuery('body').append(player_wrap)
    
jQuery(document).ready ->
    fetch_feeds()
    add_player_box()