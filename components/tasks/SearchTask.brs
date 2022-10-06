' Copyright © 2022 by Intellectual Reserve, Inc. All rights reserved.
' Created by: James Folk

' Note that we need to import this file in HomeButtonTask.xml using relative path.
sub Init()
    ' set the name of the function in the Task node component to be executed when the state field changes to RUN
    ' in our case this method executed after the following cmd: m.contentTask.control = "run"(see Init method in MainScene)
    m.top.functionName = "GetContent"
end sub


sub GetContent()
    ' request the content feed from the API
    xfer = CreateObject("roURLTransfer")
    xfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
    xfer.SetURL("https://jonathanbduval.com/roku/feeds/roku-developers-feed-v1.json")
    rsp = xfer.GetToString()
    rootChildren = []
    rows = {}

    ' parse the feed and build a tree of ContentNodes to populate the GridView
    json = ParseJson(rsp)
    if json <> invalid
        rowIndex=0
        for each category in json
            value = json.Lookup(category)
            if Type(value) = "roArray" ' if parsed key value having other objects in it
                if category <> "series" ' ignore series for this phase
                    row = {}
                    row.title = category
                    row.children = []
                    for each item in value ' parse items and push them to row
                        ' itemData = GetItemData(item, rowIndex)
                        itemData = GetChurchItemData(item, rowIndex)
                        if itemData <> invalid
                            row.children.Push(itemData)
                        end if
                    end for
                    rootChildren.Push(row)
                    rowIndex = rowIndex + 1
                end if
            end if
        end for
        ' set up a root ContentNode to represent rowList on the SearcnScreen
        contentNode = CreateObject("roSGNode", "ContentNode")
        contentNode.Update({
            children: rootChildren
        }, true)
        ' populate content field with root content node.
        ' Observer(see OnSearchContentLoaded in MainScene.brs) is invoked at that moment
        m.top.content = contentNode
    end if
end sub

function GetChurchItemData(video as Object, rowIndex as Integer) as Object
    if video = invalid then return invalid
    if video.id = invalid then return invalid
    if video.hlsUrl = invalid then return invalid
    if video.imageRenditions = invalid then return invalid

    if video.videoRenditions = invalid then return invalid
    if video.videoRenditions.count() <= 0 then return invalid

    images = []
    rimages = video.imageRenditions.tokenize(chr(10))'("/n")'newline
    for each image in rimages
        img = image.tokenize(",")
        if img.count() = 2 
            dimensions = img[0].tokenize("x")
            if dimensions.count() = 2 
                width = val(dimensions[0])
                height = val(dimensions[1])
                if invalid <> width and height <> invalid
                    dimension = height * width
                    images.Push({ dimension: dimension, size: img[0], url: img[1] })
                end if
            end if
        end if

    end for
    images.sortby("dimension")

    if images.count() <= 0 then return invalid

    item = {}

    item.description = video.description
    item.title = video.title
    item.releaseDate = video.publishedDate
    item.id = video.id
    item.rowIndex = rowIndex

    item.images = images

    item.url = video.videoRenditions[0].url
    item.streamFormat = video.videoRenditions[0].type

    return item
end function