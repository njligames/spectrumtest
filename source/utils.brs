' Copyright © 2022 by Intellectual Reserve, Inc. All rights reserved.
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

' ' Helper function convert AA to Node
' function ContentListToSimpleNode(contentList as Object, nodeType = "ContentNode" as String) as Object
'     result = CreateObject("roSGNode", nodeType) ' create node instance based on specified nodeType
'     if result <> invalid
'         ' go through contentList and create node instance for each item of list
'         for each itemAA in contentList
'             item = CreateObject("roSGNode", nodeType)
'             item.SetFields(itemAA)
'             result.AppendChild(item)
'         end for
'     end if
'     return result
' end function

' ' Helper function convert seconds to mm:ss format
' ' getTime(138) returns 2:18
' function GetTime(length as Integer) as String
'     minutes = (length \ 60).ToStr()
'     seconds = length MOD 60
'     if seconds < 10
'        seconds = "0" + seconds.ToStr()
'     else
'        seconds = seconds.ToStr()
'     end if
'     return minutes + ":" + seconds
' end function


function GetImageRenditionUrl(images as Dynamic, width as Integer, height as Integer) as String
    desiredRendition = str(width) + "x" + str(height)

    ' Find the image that matches and return the url
    for each image in images
        if lcase(image.size) = desiredRendition then return image.url
    end for

    ' Find the dimension that is closest or larger and return the url
    dimension = width * height
    for each image in images
        if image.dimension >= dimension
            return image.url
        end if
    end for

    ' If there doesn't exist a dimension that is larger then or equal in the images array, return the last image in the array.
    return images[images.count() - 1].url
end function

' function GetImageRenditionArray(imageRenditions as String) as Dynamic
'     images = []
'     rimages = imageRenditions.tokenize(chr(10))'("/n")'newline
'     for each image in rimages
'         img = image.tokenize(",")
'         if img.count() = 2 
'             dimensions = img[0].tokenize("x")
'             if dimensions.count() = 2 
'                 width = val(dimensions[0])
'                 height = val(dimensions[1])
'                 if invalid <> width and height <> invalid
'                     dimension = height * width
'                     images.Push({ dimension: dimension, size: img[0], url: img[1] })
'                 end if
'             end if
'         end if

'     end for
'     images.sortby("dimension")
'     return images
' end function

' function GetCollectionItem(collection as Object, rowIndex as Integer, videoLibrary as Object) as Object
'     images = GetImageRenditionArray(collection.imageRenditions)
'     if images.count() <= 0 then return Invalid

'     item = {}
'     item.description = "N/A"
'     item.title = collection.name
'     item.releaseDate = "N/A"
'     item.id = collection.id
'     item.rowIndex = rowIndex
'     item.images = images

'     item.url = "N/A"
'     item.streamFormat = "N/A"

'     base = getConstants("COLLECTIONS_BASE_URL")
'     endpoint = collection.id.tokenize(":")
'     item.collection_url = base + endpoint[0] + "_" + endpoint[1] + ".json"

'     item.videos = collection.videos

'     return item
' end function

function GetVideoItem(item as Object) as Object
    ' if video = Invalid then return Invalid
    ' if video.id = Invalid then return Invalid
    ' if video.hlsUrl = Invalid then return Invalid
    ' if video.imageRenditions = Invalid then return Invalid

    ' if video.videoRenditions = Invalid then return Invalid
    ' if video.videoRenditions.count() <= 0 then return Invalid

    ' images = GetImageRenditionArray(video.imageRenditions)

    ' if images.count() <= 0 then return Invalid

    ' item = {}

    ' item.description = video.description
    ' item.title = video.titlegg
    ' item.releaseDate = video.publishedDate
    ' item.id = video.id
    ' item.rowIndex = rowIndex

    ' item.images = images

    ' item.url = video.videoRenditions[0].url
    ' item.streamFormat = video.videoRenditions[0].type
    ' item.isEvent = false

    videoItem = {}
    videoItem.description = StringRemoveHTMLTags(item.description)
    videoItem.title = item.title
    videoItem.releaseDate = item.published
    videoItem.image = item.media.m

    return videoItem
end function

' function GetEventsRail(url as String) as Object
    
'     xfer = CreateObject("roURLTransfer")
'     xfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
'     xfer.SetURL(url)
    
'     rootChildren = []

'     rsp = xfer.GetToString()
'     json = ParseJson(rsp)
'     if json <> Invalid
'         events = json["events"]

'         row = {}
'         row.title = "event"
'         row.children = []

'         for each video in events
'             item = GetVideoEventItem(video, 0)
'             if item <> Invalid
'                 row.children.Push(item)
'             end if
'         end for

'         rootChildren.Push(row)

'     end if

'     return rootChildren
' end function

' function GetVideoEventItem(video as Object, rowIndex as Integer) as Object
'     if video = Invalid then return Invalid
'     if video.id = Invalid then return Invalid
'     if video.hlsUrl = Invalid then return Invalid
'     if video.imageRenditions = Invalid then return Invalid

'     images = GetImageRenditionArray(video.imageRenditions)

'     if images.count() <= 0 then return Invalid

'     item = {}
'     item.description = video.description
'     item.title = video.title
'     item.id = video.id
'     item.rowIndex = rowIndex
'     item.images = images
'     item.url = video.hlsUrl
'     item.streamFormat = "hls"
'     item.isEvent = true

'     date_now = CreateObject("roDateTime")

'     ' endDateTime is when the video should stop being live, expirationDateTime is when the video will no longer 
'     ' be available to view and when we should stop showing it in the app, startDateTime is when the event that is 
'     ' being streamed will start, streamStartDateTime is when the stream actually starts and will almost always be before the startDateTime.

'     endDateTime = CreateObject("roDateTime")
'     endDateTime.FromISO8601String(video["endDateTime"])
'     item.isEventLive = true
'     if endDateTime.AsSeconds() > date_now.AsSeconds()
'         item.IsEventLive = false
'     end if

'     expirationDateTime = CreateObject("roDateTime")
'     expirationDateTime.FromISO8601String(video["expirationDateTime"])
'     ' if expirationDateTime.AsSeconds() > date_now.AsSeconds()
'     '     return Invalid
'     ' end if
'     item.expirationDateTime = video["expirationDateTime"]

'     startDateTime = CreateObject("roDateTime")
'     startDateTime.FromISO8601String(video["startDateTime"])
'     item.startDateTime = video["startDateTime"]

'     streamStartDateTime = CreateObject("roDateTime")
'     streamStartDateTime.FromISO8601String(video["streamStartDateTime"])
'     item.streamStartDateTime = video["streamStartDateTime"]

'     item.isEventUpcoming = true
'     item.isEventLive = false
'     item.isEventOld = false

'     return item
' end function

' function convertTime(time as string) as string
'     dt = CreateObject("roDateTime")
'     dt.FromISO8601String(time)

'     timeOfDay = "AM"
'     hours = dt.GetHours()
'     if hours > 12
'         timeOfDay = "PM"
'         hours = hours - 12
'     end if

'     minutes = dt.GetMinutes()

'     value = Substitute("{0}:{1} {2}", hours.ToStr(), minutes.ToStr(), timeOfDay)
'     if minutes < 10
'         value = Substitute("{0}:0{1} {2}", hours.ToStr(), minutes.ToStr(), timeOfDay)
'     end if

'     return value
' end function