' Created by: James Folk

sub Init()

    m.rowList = m.top.FindNode("rowList")

    m.top.ObserveField("visible", "OnVisibleChange")

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

function onKeyEvent(key as String, press as Boolean) as Boolean

    handled = false
    if press
      if key = "back"
        handled = false
      else
        if m.focus = m.rowList.id
        end if
        handled = true
      end if
    end if

    return handled
  end function
