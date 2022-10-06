' Copyright © 2022 by Intellectual Reserve, Inc. All rights reserved.
' Created by: James Folk

' entry point of  MainScene
' Note that we need to import this file in MainScene.xml using relative path.
sub Init()
    ' set background color for scene. Applied only if backgroundUri has empty value
    m.top.backgroundColor = "0x662D91"
    m.top.backgroundUri= "pkg:/images/background.png"
    m.loadingIndicator = m.top.FindNode("loadingIndicator") ' store loadingIndicator node to m

    m.timer = m.top.findNode("animation_timer")
    m.timer.observeField("fire", "onTimerFireChange")
    m.timer.duration = 1
    m.timer.control = "start"

    configureAnimatedPosters()

    m.InputTask=createObject("roSgNode","inputTask")                
    m.InputTask.observefield("inputData","handleInputEvent")        
    m.InputTask.control="RUN"                                       

end sub

' The OnKeyEvent() function receives remote control key events
function OnKeyEvent(key as String, press as Boolean) as boolean
    result = false
    if press
        ' handle "back" key press
        if key = "back"
            numberOfScreens = m.screenStack.Count()
            ' close top screen if there are two or more screens in teh screen stack
            if numberOfScreens > 1
                CloseScreen(invalid)
                result = true
            end if
        end if
    end if
    ' The OnKeyEvent() function must return true if the component handled the event,
    ' or false if it did not handle the event.
    return result
end function

sub configureAnimatedPosters()

    di = CreateObject ("roDeviceInfo")
    displaySize = di.GetDisplaySize ()
    displayMode = di.GetDisplayMode ()
    supportedGraphicsResolutions = di.GetSupportedGraphicsResolutions()
    uiResolution = di.GetUIResolution()

    dimension = 162

    if ucase(uiResolution.name) = "FHD"
        dimension = dimension * 2 / 3
    end if

    x = (1280 / 2) - (dimension / 2)
    y = (720 / 2) - (dimension / 2)
    m.ap_AnimatedPoster = m.top.createChild("ap_AnimatedPoster")
    m.ap_AnimatedPoster.translation = [x, y]
    m.ap_AnimatedPoster.width = dimension
    m.ap_AnimatedPoster.height = dimension
    m.ap_AnimatedPoster.spriteSheetUri = "pkg:/images/s.png"

    m.ap_AnimatedPoster.frameOffsets = [
        [0, 0]
        [dimension * 1, 0]
        [dimension * 2, 0]
        [dimension * 3, 0]
        [dimension * 4, 0]
        [dimension * 5, 0]
    ]

    m.ap_AnimatedPoster.duration = 1 / 15
    m.ap_AnimatedPoster.control = "start"
  
end sub

sub onTimerFireChange()
    m.ap_AnimatedPoster.visible = false
    ' InitScreenStack()
    ShowHomeScreen()
    RunHomeTask() ' retrieving content
end sub

sub handleInputEvent(msg)                                                               
    ? "in handleInputEvent()"                                                           
    if type(msg) = "roSGNodeEvent" and msg.getField() = "inputData"                     
        deeplink = msg.getData()                                                        
        if deeplink <> invalid                                                          
            handleDeepLink(deeplink)                                                    
        end if                                                                          
    end if                                                                              
end sub                                                                                 

sub handleDeepLink(deeplink as object)             
  if validateDeepLink(deeplink)                         
    playVideo(m.mediaIndex[deeplink.id].url)            
  else                                                  
    print "deeplink not validated"                      
  end if                                                
end sub                                            

function validateDeepLink(deeplink as Object) as Boolean                                                         
    mediatypes={movie:"movie",episode:"episode",season:"season",series:"series"}                                   
    if deeplink <> Invalid                                                                                         
        ? "mediaType = "; deeplink.type                                                                            
        ? "contentId = "; deeplink.id                                                                              
        ? "content= "; m.mediaIndex[deeplink.id]                                                                   
        if deeplink.type <> invalid 
          if mediatypes[deeplink.type]<> invalid                                                                   
            if m.mediaIndex[deeplink.id] <> invalid                                                                
              if m.mediaIndex[deeplink.id].url <> invalid                                                          
                return true                                                                                        
              else                                                                                                 
                  print "invalid deep link url"                                                                    
              end if                                                                                               
            else                                                                                                   
              print "bad deep link contentId"                                                                      
            end if                                                                                                 
          else                                                                                                     
            print "unknown media type"                                                                             
          end if                                                                                                   
        else                                                                                                       
          print "deeplink.type string is invalid"                                                                  
        end if                                                                                                     
    end if                                                                                                         
    return false                                                                                                   
end function                                                                                                     

Sub playVideo(url = invalid)                                                                                                                         
    ? "url= "; url                                                                                                                                   
    if type(url) = "roSGNodeEvent"   ' passed from observe callback'                                                                                 
        m.videoContent.url = m.RowList.content.getChild(m.RowList.rowItemFocused[0]).getChild(m.RowList.rowItemFocused[1]).URL                       
        'rowItemFocused[0] is the row and rowItemFocused[1] is the item index in the row                                                             
    else                                                                                                                                             
        m.videoContent.url = url                                                                                                                     
    end if                                                                                                                                           
                                                                                                                                                     
    m.videoContent.streamFormat = "mp4"                                                                                                              
    keepPlaying = false                                                                                                                              
                                                                                                                                                     
    m.Video.content = m.videoContent                                                                                                                 
    m.Video.visible = "true"                                                                                                                         
    m.Video.control = "play"                                                                                                                         
                                                                                                                                                     
    m.vector2danimation = m.top.FindNode("moveOverhangPanelUp")                                                                                      
    m.vector2danimation.repeat = false                                                                                                               
    m.vector2danimation.control = "start"                                                                                                            
End Sub                                                                                                                                              

sub ShowHomeScreen()
  m.HomeScreen = CreateObject("roSGNode", "HomeScreen")
  ' m.HomeScreen.ObserveField("eventRowItemSelected", "OnHomeScreenEventItemSelected")
  ' m.HomeScreen.ObserveField("rowItemSelected", "OnHomeScreenItemSelected")

  ' m.search_button = m.HomeScreen.FindNode("search_button")
  ' m.search_button.ObserveField("buttonSelected", "OnSearchButtonSelected")

  ' m.home_button = m.HomeScreen.FindNode("home_button")
  ' m.home_button.ObserveField("buttonSelected", "OnHomeButtonSelected")

  ' m.collections_button = m.HomeScreen.FindNode("collections_button")
  ' m.collections_button.ObserveField("buttonSelected", "OnCollectionsButtonSelected")

  ' m.settings_button = m.HomeScreen.FindNode("settings_button")
  ' m.settings_button.ObserveField("buttonSelected", "OnSettingsButtonSelected")

  ShowScreen(m.HomeScreen) ' show HomeScreen
end sub

sub ShowScreen(node as Object)
  ' show new screen
  m.top.AppendChild(node)
  node.visible = true
  node.SetFocus(true)
end sub