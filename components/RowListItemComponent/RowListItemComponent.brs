' Created by: James Folk

sub Init()
    m.poster = m.top.FindNode("poster")
    m.titleLabel = m.top.FindNode("titleLabel")
    m.descriptionLabel = m.top.FindNode("descriptionLabel")
end sub

sub OnContentSet()
    content = m.top.itemContent
    if content <> invalid 
        m.poster.uri = content.image
    end if
end sub
