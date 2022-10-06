' Created by: James Folk

sub RunHomeTask()
    m.homeButtonTask = CreateObject("roSGNode", "HomeButtonTask")
    m.homeButtonTask.ObserveField("content", "OnHomeContentLoaded")
    m.homeButtonTask.control = "run"
    m.loadingIndicator.visible = true
end sub

sub OnHomeContentLoaded()
    m.HomeScreen.SetFocus(true)
    m.loadingIndicator.visible = false
    m.HomeScreen.content = m.homeButtonTask.content

    m.top.signalBeacon("AppLaunchComplete")
end sub
