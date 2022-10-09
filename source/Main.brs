' Created by: James Folk

sub Main(args)
    ShowChannelRSGScreen(args)
end sub

sub ShowChannelRSGScreen(args)
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.SetMessagePort(m.port)
    screen.CreateScene("MainScene")

    screen.Show()

    while true 
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.IsScreenClosed() then return
        end if
    end while
end sub
