' Copyright © 2022 by Intellectual Reserve, Inc. All rights reserved.
' Created by: James Folk

sub Init()
    ' di = CreateObject("roDeviceInfo")

    m.rowList = m.top.FindNode("rowList")
    ' m.eventRowList = m.top.FindNode("eventRowList")

    m.top.ObserveField("visible", "OnVisibleChange")

    ' initMenuButtons(m.rowList)
    m.rowList.SetFocus(true)

    m.rowList.ObserveField("rowItemFocused", "OnItemFocused")

end sub


sub OnVisibleChange()
    if m.top.visible = true
    m.rowList.SetFocus(true)
    end if
end sub

sub OnItemFocused() ' invoked when another item is focused
    focusedIndex = m.rowList.rowItemFocused ' get position of focused item
    row = m.rowList.content.GetChild(focusedIndex[0]) ' get all items of row
    item = row.GetChild(focusedIndex[1]) ' get focused item
end sub

' sub initMenuButtons(ctrlFocus)
'     m.search_button = m.top.FindNode("search_button")
'     m.home_button = m.top.FindNode("home_button")
'     m.collections_button = m.top.FindNode("collections_button")
'     m.settings_button = m.top.FindNode("settings_button")

'     m.current_menu_item = m.home_button
'     m.current_content_item = ctrlFocus

'     m.black_fade = m.top.FindNode("black_fade")

'     hideBlackFade()

'     ctrlFocus.SetFocus(true)
'     m.focus = ctrlFocus.id
' end sub

' sub showBlackFade()
'     m.black_fade.uri = "pkg:/images/black_fade.png"
' end sub

' sub hideBlackFade()
'     m.black_fade.uri = ""
' end sub

' sub focusMenuButtonStart()
'     m.current_menu_item.setFocus(true)
'     m.focus = m.current_menu_item.id
'     showBlackFade()
' end sub

' sub focusMenuButton(btn)
'     m.current_menu_item = btn
'     m.current_menu_item.setFocus(true)
'     m.focus = m.current_menu_item.id
' end sub

' sub focusScreenStart()
'     m.current_content_item.setFocus(true)
'     m.focus = m.current_content_item.id
'     hideBlackFade()
' end sub

function onKeyEvent(key as String, press as Boolean) as Boolean

    handled = false
    if press
      if key = "back"
        handled = false
      else
        if m.focus = m.rowList.id
            if key = "up"
                ' initMenuButtons(m.eventRowList)
            end if
            if key = "left"
                ' focusMenuButtonStart()
            end if
        end if
        handled = true
      end if
    end if

    return handled
  end function
