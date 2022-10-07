' Created by: James Folk

sub Init()
    m.top.functionName = "GetContent"
end sub

sub GetContent()
    xfer = CreateObject("roURLTransfer")
    xfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
    xfer.AddHeader("X-Access-Key", "$2b$10$aoACF.9P0WVp1wi8w2P.T.WuxaHxuiqzDvHAjg1WgAit2eXUKfJjy")
    xfer.SetURL(getConstants("HOME_URL"))
    
    rsp = xfer.GetToString()
    json = ParseJson(rsp)
    if json <> Invalid
        rootChildren = []

        row = {}
        row.children = []

        record = json["record"]

        row.children.Push(GetItem(record.ScreenA))
        row.children.Push(GetItem(record.ScreenB))

        rootChildren.Push(row)

        contentNode = CreateObject("roSGNode", "ContentNode")
        contentNode.Update({
            children: rootChildren
        }, true)
        m.top.content = contentNode

    end if

end sub

function GetItem(item as Object) as Object

    videoItem = {}
    videoItem.title = item.title
    videoItem.logo = item.logo
    videoItem.numberSet = item.numberSet

    return videoItem
end function