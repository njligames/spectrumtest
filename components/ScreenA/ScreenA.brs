' Created by: James Folk

sub Init()
  di = CreateObject ("roDeviceInfo")
  m.displaySize = di.GetDisplaySize ()

  m.background = m.top.FindNode("background")
  m.list = m.top.FindNode("list")
  m.title = m.top.FindNode("title")
  m.button = m.top.FindNode("button")
  m.image = m.top.FindNode("image")

  m.background.width = m.displaySize.w
  m.background.height = m.displaySize.h
  m.background.translation = [0, 0]

  m.title.width = m.displaySize.w

  m.button.ObserveField("buttonSelected", "OnButtonSelected")
  rect = m.button.boundingRect()
  centerx = (m.displaySize.w - rect.width) / 2
  m.button.translation = [ centerx, m.displaySize.h - m.button.height - 21 ]

  m.top.ObserveField("visible", "OnVisibleChange")
  m.top.ObserveField("content", "OnContentChange")

  m.button.SetFocus(true)
end sub


sub OnVisibleChange()
  if m.top.visible = true
    m.button.SetFocus(true)
  end if
end sub

sub OnButtonSelected()
  ShowScreenB()
  RunContentTask() 
end sub


sub OnContentChange()
  content = ScreenAContent(m.top.content)
  m.title.text = content.title
  m.image.uri = content.logo
  content.numberset.sort()
  max = 5
  current = 0
  ' children=[]
  contentNode = CreateObject("roSGNode", "ContentNode")
  for each number in content.numberset
    if current < max 
      item = CreateObject("roSGNode", "ContentNode")
      item.title = number
      contentNode.AppendChild(item)
    end if

    current = current + 1
  end for
  ' contentNode = CreateObject("roSGNode", "ContentNode")
  ' contentNode.Update({
  '     children: children
  ' }, true)
  m.list.content = contentNode

  x = (m.displaySize.w / 2) - (m.image.width / 2)
  y = (m.displaySize.h / 2) - (m.image.height / 2)
  m.image.translation = [x,y]
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean

    handled = false
    if press
      if key = "back"
        handled = false
      else
        if m.focus = m.button.id
        end if
        handled = true
      end if
    end if

    return handled
  end function
