' Created by: James Folk

sub Init()
    m.top.backgroundColor = "0xFFFFFF"
    m.loadingIndicator = m.top.FindNode("loadingIndicator") 

    ShowScreenA()
    RunContentTask() 

end sub

function OnKeyEvent(key as String, press as Boolean) as boolean
    result = false
    if press
        if key = "back"
        end if
    end if
    return result
end function
