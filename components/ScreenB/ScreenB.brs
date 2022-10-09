' Created by: James Folk

' Default initialization of the screen
sub Init()
  ' How far it is between the edge of the screen to a control.
  m.EDGEMARGIN = 21

  ' How far it is between the image and the list
  m.ITEMMARGIN = 21 

  ' Cache the screen dimensions
  di = CreateObject ("roDeviceInfo")
  m.displaySize = di.GetDisplaySize ()

  m.background = m.top.FindNode("background")
  m.title = m.top.FindNode("title")
  m.image = m.top.FindNode("image")
  m.list = m.top.FindNode("list")
  m.button = m.top.FindNode("button")

  ' Adjust background to screen dimensions 
  m.background.width = m.displaySize.w
  m.background.height = m.displaySize.h

  ' Adjust title to screen dimensions 
  m.title.width = m.displaySize.w
  m.title.translation[1] = m.EDGEMARGIN

  ' Set the callback function for when the button is pressed.
  m.button.ObserveField("buttonSelected", "OnButtonSelected")

  ' Adjust button to screen dimensions 
  centerx = (m.displaySize.w - m.button.boundingRect().width) / 2
  m.button.translation = [ centerx, m.displaySize.h - m.button.height - m.EDGEMARGIN ]

  ' Set the callback function for when the content changes.
  m.top.ObserveField("content", "OnContentChange")

  m.focus = m.button.id
end sub

' When the user clicks the only button on the screen.
sub OnButtonSelected()
  ShowScreenA()
  RunContentTask() 
end sub

' Used to populate the dynamic content.
sub OnContentChange()
  ' Get the content that was retrieved from the server for Screen A
  content = ScreenBContent(m.top.content)
  m.title.text = content.title
  m.image.uri = content.logo
  m.numberset = content.numberset

  ' Run the function to do the coding challenge logic for Screen A
  m.list.content = CreateScreenBContentNode(m.numberset)

  ' Adjust the image to be in the center of the screen.
  x = (m.displaySize.w / 2) - (m.image.width / 2)
  y = (m.displaySize.h / 2) - (m.image.height / 2)
  m.image.translation = [x,y]

  ' Adjust the list location, relative to the image.
  x = (m.displaySize.w / 2) - (m.list.itemSize[0] / 2)
  y = m.image.translation[1] + m.image.height + m.ITEMMARGIN 
  m.list.translation = [ x, y ]
end sub

' Focus will jump between the button and the list when the user presses and d-pad direction
function onKeyEvent(key as String, press as Boolean) as Boolean

    handled = false
    if press
      if key = "back"
        handled = false
      else
        if m.focus = m.button.id
          if key = "up" or key = "down" or key = "left" or key = "right"
            m.list.SetFocus(true)
            m.focus = m.list.id
          end if
        else if m.focus = m.list.id
          if key = "up" or key = "down" or key = "left" or key = "right"
            m.button.SetFocus(true)
            m.focus = m.button.id
          end if
        end if
        handled = true
      end if
    end if

    return handled
  end function
