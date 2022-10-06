' Copyright © 2022 by Intellectual Reserve, Inc. All rights reserved.
' Created by: James Folk

sub ShowHelpScreen(node as object)
    m.helpScreen = CreateObject("roSGNode", "HelpScreen")

    m.search_button = m.helpScreen.FindNode("search_button")
    m.search_button.ObserveField("buttonSelected", "OnSearchButtonSelected")

    m.home_button = m.helpScreen.FindNode("home_button")
    m.home_button.ObserveField("buttonSelected", "OnHomeButtonSelected")

    m.settings_button = m.helpScreen.FindNode("settings_button")
    m.settings_button.ObserveField("buttonSelected", "OnSettingsButtonSelected")

    m.account_button = m.helpScreen.FindNode("account_button")
    m.account_button.ObserveField("buttonSelected", "OnAccountButtonSelected")

    m.help_button = m.helpScreen.FindNode("help_button")
    m.help_button.ObserveField("buttonSelected", "OnHelpButtonSelected")

    m.about_button = m.helpScreen.FindNode("about_button")
    m.about_button.ObserveField("buttonSelected", "OnAboutButtonSelected")

    ShowScreen(m.helpScreen)
end sub
