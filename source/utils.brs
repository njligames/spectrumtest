' Created by: James Folk

Function getConstants(key as String) as String
    baseUrl = "https://api.jsonbin.io/v3/b/631f5e595c146d63ca98e072"

    map = {
        "HOME_URL" : baseUrl
    }

    return map[key]
end Function

sub ShowScreen(node as Object)
  m.top.AppendChild(node)
  node.visible = true
  node.SetFocus(true)
end sub

sub ShowScreenA()
  m.Screen = CreateObject("roSGNode", "ScreenA")

  ShowScreen(m.Screen)
end sub

sub ShowScreenB()
  m.Screen = CreateObject("roSGNode", "ScreenB")

  ShowScreen(m.Screen)
end sub

function ScreenAContent(content as object) as object
    return content.GetChild(0).GetChild(0)
end function

function ScreenBContent(content as object) as object
    return content.GetChild(0).GetChild(1)
end function

sub RunContentTask()
    m.contentTask = CreateObject("roSGNode", "ContentTask")
    m.contentTask.ObserveField("content", "OnContentTaskLoaded")
    m.contentTask.control = "run"
    if invalid <> m.loadingIndicator then m.loadingIndicator.visible = true
end sub

sub OnContentTaskLoaded()
    if invalid <> m.loadingIndicator then m.loadingIndicator.visible = false
    m.Screen.content = m.contentTask.content
end sub