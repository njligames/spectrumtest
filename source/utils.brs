' Created by: James Folk

Function getConstants(key as String) as String
    baseUrl = "https://www.flickr.com/services/feeds"
    endpoint = "photos_public.gne"
    jsonrequirement = "format=json&nojsoncallback=1&tags=puppies"

    map = {
        "HOME_URL" : baseUrl + "/" + endpoint + "?" + jsonrequirement
    }

    return map[key]
end Function

function StringRemoveHTMLTags(baseStr as String) as String
    r = createObject("roRegex", "<[^<]+?>", "i")
    return r.replaceAll(baseStr, "")
end function

function GetVideoItem(item as Object) as Object

    videoItem = {}
    videoItem.description = StringRemoveHTMLTags(item.description)
    videoItem.title = item.title
    videoItem.releaseDate = item.published
    videoItem.image = item.media.m

    return videoItem
end function
