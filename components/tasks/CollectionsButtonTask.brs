' Copyright © 2022 by Intellectual Reserve, Inc. All rights reserved.
' Created by: James Folk

' Note that we need to import this file in CollectionsButtonTask.xml using relative path.
sub Init()
    ' set the name of the function in the Task node component to be executed when the state field changes to RUN
    ' in our case this method executed after the following cmd: m.contentTask.control = "run"(see Init method in MainScene)
    m.top.functionName = "GetContent"
end sub

sub GetContent()
    xfer = CreateObject("roURLTransfer")
    xfer.SetCertificatesFile("common:/certs/ca-bundle.crt")

    xfer.SetURL(m.top.url)
    
    rsp = xfer.GetToString()
    json = ParseJson(rsp)
    if json <> Invalid
        rootChildren = []

        videos_temp = json["videos"]
        collections_temp = json["collections"]

        video_library = {}
        for each video in videos_temp
            video_library[video.id] = video
        end for

        collections = {}
        for each collection in collections_temp
            sortOrder = collection.sortOrder
            if sortOrder <> Invalid
                collections[Str(sortOrder)] = collection
            end if
        end for

        for each collection_index in collections
            collection = collections[collection_index]

            row = {}
            row.title = collection["name"]
            row.children = []

            num_videos = collection["videos"].count()
            num_collections = collection["collections"].count()

            if num_videos = 0 and num_collections <> 0
                row_videos = {}
                for each collection in collection["collections"]
                    sortOrder = collection.sortOrder
                    if sortOrder <> Invalid
                        row_videos[Str(sortOrder)] = collection
                    end if
                end for

                for each video in row_videos.Items()
                    item = GetCollectionItem(video.value, collection_index.toInt(), video_library)
                    row.children.Push(item)
                end for
            else if num_videos <> 0 and num_collections = 0
                row_videos = {}
                for each video_id in collection["videos"]
                    video = video_library[video_id]
                    sortOrder = video.sortOrder
                    if sortOrder <> Invalid
                        row_videos[Str(sortOrder)] = video
                    end if
                end for

                for each video in row_videos.Items()
                    item = GetVideoItem(video.value, collection_index.toInt())
                    row.children.Push(item)
                end for
            end if

            rootChildren.Push(row)
        end for

        contentNode = CreateObject("roSGNode", "ContentNode")
        contentNode.Update({
            children: rootChildren
        }, true)
        m.top.content = contentNode

    end if

end sub
