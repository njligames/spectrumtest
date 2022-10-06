' Copyright © 2022 by Intellectual Reserve, Inc. All rights reserved.
' Created by: James Folk

sub ShowSearchScreen(node as object)
    ' create new instance of details screen
    m.searchScreen = CreateObject("roSGNode", "SearchScreen")

    m.search_button = m.searchScreen.FindNode("search_button")
    m.search_button.ObserveField("buttonSelected", "OnSearchButtonSelected")

    m.home_button = m.searchScreen.FindNode("home_button")
    m.home_button.ObserveField("buttonSelected", "OnHomeButtonSelected")

    m.collections_button = m.searchScreen.FindNode("collections_button")
    m.collections_button.ObserveField("buttonSelected", "OnCollectionsButtonSelected")

    m.settings_button = m.searchScreen.FindNode("settings_button")
    m.settings_button.ObserveField("buttonSelected", "OnSettingsButtonSelected")

    ShowScreen(m.searchScreen)
end sub
