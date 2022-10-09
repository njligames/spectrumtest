' Created by: James Folk

' URL constants that are used through out the channel.
' @param key The key to the url value to return.
function getConstants(key as String) as String
    baseUrl = "https://api.jsonbin.io/v3/b/631f5e595c146d63ca98e072"

    map = {
        "HOME_URL" : baseUrl
    }

    return map[key]
end function

' Utility function to display a screen.
' @param node The screen to show.
sub ShowScreen(node as Object)
  m.top.AppendChild(node)
  node.visible = true
  node.SetFocus(true)
end sub

' Show Screen A
sub ShowScreenA()
  m.Screen = CreateObject("roSGNode", "ScreenA")

  ShowScreen(m.Screen)
end sub

' Show Screen B
sub ShowScreenB()
  m.Screen = CreateObject("roSGNode", "ScreenB")

  ShowScreen(m.Screen)
end sub

' Returns the content for Screen A that was retrieved from the server.
' @param content The root content that was retrieved from the server.
function ScreenAContent(content as object) as object
    return content.GetChild(0).GetChild(0)
end function

' Returns the content for Screen B that was retrieved from the server.
' @param content The root content that was retrieved from the server.
function ScreenBContent(content as object) as object
    return content.GetChild(0).GetChild(1)
end function

' Runs the task `ContentTask.xml` that retrives the data from the server.
sub RunContentTask()
    m.contentTask = CreateObject("roSGNode", "ContentTask")
    m.contentTask.ObserveField("content", "OnContentTaskLoaded")
    m.contentTask.control = "run"
    if invalid <> m.loadingIndicator then m.loadingIndicator.visible = true
end sub

' The callback function retrieved after running the `ContentTask.xml`
sub OnContentTaskLoaded()
    if invalid <> m.loadingIndicator then m.loadingIndicator.visible = false
    m.Screen.content = m.contentTask.content
end sub

' Creates a `ContentNode` for Screen A, that can be used in a `LabelList`
' @param numberset The array of numbers that was retrieved from the server
function CreateScreenAContentNode(numberset as Dynamic) as object
  numberset.Sort("r")
  max = 5
  current = numberset.Count()
  contentNode = CreateObject("roSGNode", "ContentNode")
  contentNode.id = "listContent"
  contentNode.role = "content"
  for each number in numberset
    if current <= max 

      item = contentNode.createChild("ContentNode")
      item.title = Str(number)
    end if

    current = current - 1
  end for
  return contentNode
end function

' Creates a `ContentNode` for Screen B, that can be used in a `LabelList`
' @param numberset The array of numbers that was retrieved from the server
function CreateScreenBContentNode(numberset as Dynamic) as object
  contentNode = CreateObject("roSGNode", "ContentNode")
  contentNode.id = "listContent"
  contentNode.role = "content"

  newArray = []

  i = 0
  while i < numberset.Count()
    if numberset[i] mod 2 = 0
        newArray.Push(numberset[i])
    end if
    i = i + 1
  end while

  newArray.Sort("r")

  max = 5
  current = newArray.Count()

  for each number in newArray
    if current <= max 

      item = contentNode.createChild("ContentNode")
      item.title = Str(number)
    end if

    current = current - 1
  end for
  return contentNode
end function