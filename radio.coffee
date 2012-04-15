window.GoyakaPlayer = {}
window.GoyakaPlayer.songs = []
fetch_feeds =->
    feeds = jQuery('.fbGroupsStream li.uiUnifiedStory')
    for feed in feeds
        link = jQuery(feed).find('.uiAttachmentTitle a')
        if link.length > 0
            actor_image = jQuery(feed).find('.actorPhoto img').attr('src')
            actor_name  = jQuery(feed).find('.actorName a').html()
            message     = jQuery(feed).find('.messageBody').html()
            song = $(link[0])
            song_item = 
                actor_image: actor_image
                actor_name: actor_name
                message: message
                song: song.find('span').html()
                url: song.attr('href')
                
            window.GoyakaPlayer.songs.push(song_item)
    

get_youtube_id = (url)->
    regex_pattern = /.*v=([^&.]*)/
    matches = regex_pattern.exec(url)
    if matches.length > 1
        return matches[1]
    else
        return false
        
window.GoyakaPlayer.add_player_listeners =->
    if is_player_loaded()
        window.setInterval(pollPlayerState, 5000)
    else
        window.setTimeout(window.GoyakaPlayer.add_player_listeners, 10000)

playNext =->
    console.log('Playing next song')
    window.GoyakaPlayer.currentPlayId = window.GoyakaPlayer.currentPlayId + 1
    playSong(window.GoyakaPlayer.currentPlayId)

    
pollPlayerState =->
    player = document.getElementById('goyakaplayer')
    player_state = player.getPlayerState()
    if player_state == GoyakaPlayer.STOPPED
        playNext()
    
add_player_box =->
    player_wrap = jQuery('<div style="padding:3px; border:1px solid #000; border-radius:4px;position:absolute;top:100px;left:20%;background-color:#fff;zoom:2;z-index:99999999;"><div id="goyakatube"></div></div>')    
    jQuery('body').append(player_wrap)
    
    params = { allowScriptAccess: "always" };
    atts = { id: "goyakaplayer" };
    first_youtube_id = get_youtube_id(window.GoyakaPlayer.songs[0]['url'])
    
    swfobject.embedSWF("https://www.youtube.com/v/" + first_youtube_id + "?enablejsapi=1&playerapiid=ytplayer&version=3",
                       "goyakatube", "250", "180", "8", null, null, params, atts);
    

queue_songs =->
    player = document.getElementById('goyakaplayer')
    songs_list = window.GoyakaPlayer.songs.slice(1,window.GoyakaPlayer.songs.length)
    for song in songs_list
        console.log('Queueing ' + song['song'])
        player.cueVideoByUrl(song['url'])

play =->
    player = document.getElementById('goyakaplayer')
    player.playVideo()
    
jQuery(document).ready ->
    fetch_feeds()
    add_player_box()
    queue_songs()
    play()