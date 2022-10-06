' Created by: James Folk

sub Init()
    m.heroPoster = m.top.FindNode("heroPoster")
    m.heroPosterOverlay = m.top.FindNode("heroPosterOverlay")
    m.titleLabel = m.top.FindNode("titleLabel")
    m.descriptionLabel = m.top.FindNode("descriptionLabel")
end sub

sub OnContentSet()
    content = m.top.itemContent
    if content <> invalid 
        m.top.FindNode("poster").uri = GetImageRenditionUrl(content.images, 250, 141)


        m.descriptionLabel.text = content.description

        m.titleLabel.text = content.title

    end if
end sub
