' Copyright © 2022 by Intellectual Reserve, Inc. All rights reserved.
' Created by: James Folk

sub ShowSettingsScreen(node as object)
    m.settingsScreen = CreateObject("roSGNode", "SettingsScreen")

    m.search_button = m.settingsScreen.FindNode("search_button")
    m.search_button.ObserveField("buttonSelected", "OnSearchButtonSelected")

    m.home_button = m.settingsScreen.FindNode("home_button")
    m.home_button.ObserveField("buttonSelected", "OnHomeButtonSelected")

    m.collections_button = m.settingsScreen.FindNode("collections_button")
    m.collections_button.ObserveField("buttonSelected", "OnCollectionsButtonSelected")

    m.settings_button = m.settingsScreen.FindNode("settings_button")
    m.settings_button.ObserveField("buttonSelected", "OnSettingsButtonSelected")

    m.account_button = m.settingsScreen.FindNode("account_button")
    m.account_button.ObserveField("buttonSelected", "OnAccountButtonSelected")

    m.help_button = m.settingsScreen.FindNode("help_button")
    m.help_button.ObserveField("buttonSelected", "OnHelpButtonSelected")

    m.about_button = m.settingsScreen.FindNode("about_button")
    m.about_button.ObserveField("buttonSelected", "OnAboutButtonSelected")

    ShowScreen(m.settingsScreen)
end sub

sub OnAccountButtonSelected(event as Object)
end sub

sub OnLanguagesButtonSelected(event as Object)
end sub

sub OnHelpButtonSelected(event as Object)
    ShowHelpScreen(m.settingsScreen)
end sub

sub OnAboutButtonSelected(event as Object)
    ShowAboutScreen(m.settingsScreen)
end sub
