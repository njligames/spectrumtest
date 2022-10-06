' Copyright © 2022 by Intellectual Reserve, Inc. All rights reserved.
' Created by: James Folk

sub ShowAboutScreen(node as object)
    m.aboutScreen = CreateObject("roSGNode", "AboutScreen")

    m.search_button = m.aboutScreen.FindNode("search_button")
    m.search_button.ObserveField("buttonSelected", "OnSearchButtonSelected")

    m.home_button = m.aboutScreen.FindNode("home_button")
    m.home_button.ObserveField("buttonSelected", "OnHomeButtonSelected")

    m.settings_button = m.aboutScreen.FindNode("settings_button")
    m.settings_button.ObserveField("buttonSelected", "OnSettingsButtonSelected")


    m.terms_button = m.aboutScreen.FindNode("terms_button")
    m.terms_button.ObserveField("buttonSelected", "OnTermsButtonSelected")

    m.privacy_button = m.aboutScreen.FindNode("privacy_button")
    m.privacy_button.ObserveField("buttonSelected", "OnPrivacyButtonSelected")

    m.helpLabel = m.aboutScreen.FindNode("helpLabel")

    ShowScreen(m.aboutScreen)

    RunXmlContentTask()
end sub

sub OnTermsButtonSelected(event as Object)
    if m.aboutScreen.content <> invalid
        m.helpLabel.text = m.aboutScreen.content.getChild(0).getChild(0).data
    end if
end sub

sub OnPrivacyButtonSelected(event as Object)
    if m.aboutScreen.content <> invalid
        m.helpLabel.text = m.aboutScreen.content.getChild(1).getChild(0).data
    end if
end sub