' Copyright © 2022 by Intellectual Reserve, Inc. All rights reserved.
' Created by: James Folk

' Note that we need to import this file in MainScene.xml using relative path.

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Main Content Task Functions
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
sub RunHomeTask()
    m.homeButtonTask = CreateObject("roSGNode", "HomeButtonTask") ' create task for feed retrieving
    m.homeButtonTask.ObserveField("content", "OnHomeContentLoaded")
    m.homeButtonTask.ObserveField("eventContent", "OnHomeEventContentLoaded")
    m.homeButtonTask.control = "run" ' GetContent(see HomeButtonTask.brs) method is executed
    m.loadingIndicator.visible = true ' show loading indicator while content is loading
end sub

sub OnHomeContentLoaded() ' invoked when content is ready to be used
    m.HomeScreen.SetFocus(true) ' set focus to HomeScreen
    m.loadingIndicator.visible = false ' hide loading indicator because content was retrieved
    m.HomeScreen.content = m.homeButtonTask.content ' populate HomeScreen with content

    m.top.signalBeacon("AppLaunchComplete")
end sub

sub OnHomeEventContentLoaded() ' invoked when content is ready to be used
    m.HomeScreen.SetFocus(true) ' set focus to HomeScreen
    m.loadingIndicator.visible = false ' hide loading indicator because content was retrieved
    m.HomeScreen.eventContent = m.homeButtonTask.eventContent ' populate HomeScreen with content
end sub

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Collections Task Functions
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
sub RunCollectionsTask()
    m.collectionsButtonTask = CreateObject("roSGNode", "CollectionsButtonTask") ' create task for feed retrieving
    m.collectionsButtonTask.ObserveField("content", "OnCollectionsContentLoaded")
    m.collectionsButtonTask.url = getConstants("HOME_URL")
    m.collectionsButtonTask.control = "run" ' GetContent(see CollectionsButtonTask.brs) method is executed
    m.loadingIndicator.visible = true ' show loading indicator while content is loading
end sub

sub OnCollectionsContentLoaded() ' invoked when content is ready to be used
    m.CollectionsScreen.SetFocus(true) ' set focus to HomeScreen
    m.loadingIndicator.visible = false ' hide loading indicator because content was retrieved
    m.CollectionsScreen.content = m.collectionsButtonTask.content ' populate HomeScreen with content
end sub

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Search Task Functions
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
sub RunSearchTask()
    m.searchTask = CreateObject("roSGNode", "SearchTask") ' create task for feed retrieving
    m.searchTask.ObserveField("content", "OnSearchContentLoaded")
    m.searchTask.control = "run" ' GetContent(see SearcnTask.brs) method is executed
end sub

sub OnSearchContentLoaded() ' invoked when content is ready to be used
    m.SearchScreen.SetFocus(true) ' set focus to SearcnScreen
    m.SearchScreen.content = m.searchTask.content ' populate SearchScreen with content
end sub

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
sub RunXmlContentTask()
    m.xmlContentTask = CreateObject("roSGNode", "XmlLoaderTask")
    m.xmlContentTask.ObserveField("content", "OnXmlContentLoaded")
    m.xmlContentTask.control = "run"
end sub

sub OnXmlContentLoaded()
    m.aboutScreen.content = m.xmlContentTask.content

    m.helpLabel = m.aboutScreen.FindNode("helpLabel")

    m.helpLabel.text = m.aboutScreen.content.getChild(0).getChild(0).data
end sub
