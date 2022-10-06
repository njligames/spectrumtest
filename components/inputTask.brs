' Created by: James Folk

Sub Init()
    m.top.functionName = "listenInput"
End Sub

sub listenInput()
    port=createobject("romessageport")
    InputObject=createobject("roInput")
    InputObject.setmessageport(port)

    while true
      msg=port.waitmessage(500)
      if type(msg)="roInputEvent"
        print "INPUT EVENT!"
        if msg.isInput()
          inputData = msg.getInfo()
          for each item in inputData
            print item  +": " inputData[item]
          end for

          if inputData.DoesExist("mediaType") and inputData.DoesExist("contentID")
            deeplink = {
                id: inputData.contentID,
                type: inputData.mediaType
            }
            print "got input deeplink= "; deeplink
            m.top.inputData = deeplink
          end if
        end if
      end if
    end while
end sub
