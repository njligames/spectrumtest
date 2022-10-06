' Copyright © 2022 by Intellectual Reserve, Inc. All rights reserved.
' Created by: James Folk

sub ShowHomeScreen()
    m.HomeScreen = CreateObject("roSGNode", "HomeScreen")
    m.HomeScreen.ObserveField("eventRowItemSelected", "OnHomeScreenEventItemSelected")
    m.HomeScreen.ObserveField("rowItemSelected", "OnHomeScreenItemSelected")

    m.search_button = m.HomeScreen.FindNode("search_button")
    m.search_button.ObserveField("buttonSelected", "OnSearchButtonSelected")

    m.home_button = m.HomeScreen.FindNode("home_button")
    m.home_button.ObserveField("buttonSelected", "OnHomeButtonSelected")

    m.collections_button = m.HomeScreen.FindNode("collections_button")
    m.collections_button.ObserveField("buttonSelected", "OnCollectionsButtonSelected")

    m.settings_button = m.HomeScreen.FindNode("settings_button")
    m.settings_button.ObserveField("buttonSelected", "OnSettingsButtonSelected")

    ShowScreen(m.HomeScreen) ' show HomeScreen
end sub

sub OnHomeScreenEventItemSelected(event as Object) ' invoked when HomeScreen item is selected
    m.selectedIndex = event.GetData()
    rowContent = m.HomeScreen.eventContent.GetChild(m.selectedIndex[0])
    itemIndex = m.selectedIndex[1]

    if rowContent.getChild(itemIndex) <> invalid
        if rowContent.getChild(itemIndex).collection_url <> invalid
        else
            ShowDetailsScreen(rowContent, itemIndex)
        end if
    end if

end sub

sub OnHomeScreenItemSelected(event as Object) ' invoked when HomeScreen item is selected
    m.selectedIndex = event.GetData()
    rowContent = m.HomeScreen.content.GetChild(m.selectedIndex[0])
    itemIndex = m.selectedIndex[1]

    if rowContent.getChild(itemIndex) <> invalid
        if rowContent.getChild(itemIndex).collection_url <> invalid
        else
            ShowDetailsScreen(rowContent, itemIndex)
        end if
    end if

end sub

sub OnSearchButtonSelected(event as Object)
    CloseScreen(invalid)
    ShowSearchScreen(m.HomeScreen)
    RunSearchTask()
end sub

sub OnHomeButtonSelected(event as Object)
    CloseScreen(invalid)
    ShowHomeScreen()
    RunHomeTask()
end sub

sub OnSettingsButtonSelected(event as Object)
    CloseScreen(invalid)
    ShowSettingsScreen(m.HomeScreen)
end sub

sub OnCollectionsButtonSelected(event as Object)
    CloseScreen(invalid)
    ShowCollectionsScreen(m.HomeScreen)
    ' ShowCollectionsL2Screen(m.HomeScreen)
    ' ShowCollectionsL3Screen(m.HomeScreen)
    RunCollectionsTask()
end sub
