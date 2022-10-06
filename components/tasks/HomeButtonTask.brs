' Copyright © 2022 by Intellectual Reserve, Inc. All rights reserved.
' Created by: James Folk

sub Init()
    m.top.functionName = "GetContent"
end sub

sub GetContent()
    xfer = CreateObject("roURLTransfer")
    xfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
    xfer.SetURL(getConstants("HOME_URL"))
    
    rsp = xfer.GetToString()
    json = ParseJson(rsp)
    if json <> Invalid
        rootChildren = []

        row = {}
        row.title = "Public photos of 'puppies' From Flickr"
        row.children = []

        items = json["items"]
        for each item in items
            item = GetVideoItem(item)
            row.children.Push(item)
        end for
        rootChildren.Push(row)

        ' videos_temp = json["videos"]
        ' collections_temp = json["collections"]

        ' video_library = {}
        ' for each video in videos_temp
        '     video_library[video.id] = video
        ' end for

        ' collections = {}
        ' for each collection in collections_temp
        '     sortOrder = collection.sortOrder
        '     if sortOrder <> Invalid
        '         collections[Str(sortOrder)] = collection
        '     end if
        ' end for

        ' for collection_index = 1 to collections.count()
        '     collection = collections[Str(collection_index)]

        '     row = {}
        '     row.title = collection["name"]
        '     row.children = []

        '     num_videos = collection["videos"].count()
        '     num_collections = collection["collections"].count()

        '     ' if num_videos = 0 and num_collections <> 0
        '     '     row_videos = {}
        '     '     for each collection in collection["collections"]
        '     '         sortOrder = collection.sortOrder
        '     '         if sortOrder <> Invalid
        '     '             row_videos[Str(sortOrder)] = collection
        '     '         end if
        '     '     end for

        '     '     for each video in row_videos.Items()
        '     '         item = GetCollectionItem(video.value, collection_index, video_library)
        '     '         row.children.Push(item)
        '     '     end for
        '     ' else 
        '     if num_videos <> 0 and num_collections = 0
        '         row_videos = {}
        '         for each video_id in collection["videos"]
        '             video = video_library[video_id]
        '             sortOrder = video.sortOrder
        '             if sortOrder <> Invalid
        '                 row_videos[Str(sortOrder)] = video
        '             end if
        '         end for

        '         for each video in row_videos.Items()
        '             item = GetVideoItem(video.value, collection_index)
        '             row.children.Push(item)
        '         end for
        '     end if

        '     rootChildren.Push(row)
        ' end for

        contentNode = CreateObject("roSGNode", "ContentNode")
        contentNode.Update({
            children: rootChildren
        }, true)
        m.top.content = contentNode

        ' eventRootChildren = GetEventsRail(getConstants("EVENT_URL"))
        ' eventContentNode = CreateObject("roSGNode", "ContentNode")
        ' eventContentNode.Update({
        '     children: eventRootChildren
        ' }, true)
        ' m.top.eventContent = eventContentNode

    end if

end sub
