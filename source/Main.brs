' Created by: James Folk

' Channel entry point
sub Main(args)
    ShowChannelRSGScreen(args)
end sub

sub ShowChannelRSGScreen(args)
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.SetMessagePort(m.port)
    screen.CreateScene("MainScene")

    ' m.global = screen.getGlobalNode()
    ' ? "args= "; formatjson(args)
    ' deeplink = getDeepLinks(args)
    ' ? "deeplink= "; deeplink
    ' m.global.addField("deeplink", "assocarray", false)
    ' m.global.deeplink = deeplink

    screen.Show()

    while true 
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.IsScreenClosed() then return
        end if
    end while
end sub

' function getDeepLinks(args) as Object
'     deeplink = Invalid

'     if args.contentid <> Invalid and args.mediaType <> Invalid
'         deeplink = {
'             id: args.contentId,
'             type: args.mediaType
'         }
'     end if

'     return deeplink
' end function
