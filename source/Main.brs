' Copyright © 2022 by Intellectual Reserve, Inc. All rights reserved.
' Created by: James Folk

' Channel entry point
sub Main(args)
    ShowChannelRSGScreen(args)
end sub

sub ShowChannelRSGScreen(args)
    ' The roSGScreen object is a SceneGraph canvas that displays the contents of a Scene node instance
    screen = CreateObject("roSGScreen")
    ' message port is the place where events are sent
    m.port = CreateObject("roMessagePort")
    ' sets the message port which will be used for events from the screen
    screen.SetMessagePort(m.port)
    ' every screen object must have a Scene node, or a node that derives from the Scene node
    scene = screen.CreateScene("MainScene")

    m.global = screen.getGlobalNode()
    ? "args= "; formatjson(args)      'pretty print AA'
    deeplink = getDeepLinks(args)
    ? "deeplink= "; deeplink
    m.global.addField("deeplink", "assocarray", false)
    m.global.deeplink = deeplink

    screen.Show() ' Init method in MainScene.brs is invoked

    ' event loop
    while true 
        ' waiting for events from screen
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.IsScreenClosed() then return
        end if
    end while
end sub

function getDeepLinks(args) as Object
    deeplink = Invalid

    if args.contentid <> Invalid and args.mediaType <> Invalid
        deeplink = {
            id: args.contentId,
            type: args.mediaType
        }
    end if

    return deeplink
end function
