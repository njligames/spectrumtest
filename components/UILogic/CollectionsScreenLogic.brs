' Copyright © 2022 by Intellectual Reserve, Inc. All rights reserved.
' Created by: James Folk

sub ShowCollectionsScreen(node as object)
    m.CollectionsScreen = CreateObject("roSGNode", "CollectionsScreen")
    m.CollectionsScreen.ObserveField("rowItemSelected", "OnCollectionsScreenItemSelected")

    m.search_button = m.CollectionsScreen.FindNode("search_button")
    m.search_button.ObserveField("buttonSelected", "OnSearchButtonSelected")

    m.home_button = m.CollectionsScreen.FindNode("home_button")
    m.home_button.ObserveField("buttonSelected", "OnHomeButtonSelected")

    m.collections_button = m.CollectionsScreen.FindNode("collections_button")
    m.collections_button.ObserveField("buttonSelected", "OnCollectionsButtonSelected")

    m.settings_button = m.CollectionsScreen.FindNode("settings_button")
    m.settings_button.ObserveField("buttonSelected", "OnSettingsButtonSelected")

    ShowScreen(m.CollectionsScreen)
end sub

sub OnCollectionsScreenItemSelected(event as Object) ' invoked when HomeScreen item is selected
    grid = event.GetRoSGNode()
    ' extract the row and column indexes of the item the user selected
    m.selectedIndex = event.GetData()
    ' the entire row from the RowList will be used by the Video node
    rowContent = grid.content.GetChild(m.selectedIndex[0])
    itemIndex = m.selectedIndex[1]

    if rowContent.getChild(itemIndex) <> invalid
        collection_url = rowContent.getChild(itemIndex).collection_url
        if collection_url <> invalid
            m.collectionsButtonTask = CreateObject("roSGNode", "CollectionsButtonTask") ' create task for feed retrieving
            m.collectionsButtonTask.ObserveField("content", "OnCollectionsContentLoaded")
            m.collectionsButtonTask.url = collection_url
            m.collectionsButtonTask.control = "run" ' GetContent(see CollectionsButtonTask.brs) method is executed
            m.loadingIndicator.visible = true ' show loading indicator while content is loading
        else
            ShowDetailsScreen(rowContent, itemIndex)
        end if
    end if

end sub

sub ShowCollectionsL2Screen(node as object)
    m.CollectionsScreen = CreateObject("roSGNode", "CollectionsL2Screen")

    ShowScreen(m.CollectionsScreen)
end sub

sub ShowCollectionsL3Screen(node as object)
    m.CollectionsScreen = CreateObject("roSGNode", "CollectionsL3Screen")

    ShowScreen(m.CollectionsScreen)
end sub