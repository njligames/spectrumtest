' Created by: James Folk

sub Init()
    m.top.backgroundColor = "0x662D91"
    m.top.backgroundUri= "pkg:/images/background.png"
    m.loadingIndicator = m.top.FindNode("loadingIndicator") 

    ShowHomeScreen()
    RunHomeTask() 


    m.InputTask=createObject("roSgNode","inputTask")                
    m.InputTask.observefield("inputData","handleInputEvent")        
    m.InputTask.control="RUN"                                       

end sub

function OnKeyEvent(key as String, press as Boolean) as boolean
    result = false
    if press
        if key = "back"
        end if
    end if
    return result
end function

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

sub ShowHomeScreen()
  m.HomeScreen = CreateObject("roSGNode", "HomeScreen")

  ShowScreen(m.HomeScreen)
end sub

sub ShowScreen(node as Object)
  m.top.AppendChild(node)
  node.visible = true
  node.SetFocus(true)
end sub