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

        contentNode = CreateObject("roSGNode", "ContentNode")
        contentNode.Update({
            children: rootChildren
        }, true)
        m.top.content = contentNode

    end if

end sub
