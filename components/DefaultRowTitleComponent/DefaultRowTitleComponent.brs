' Copyright (c) 2018-2021 Roku, Inc. All rights reserved.

sub Init()
    m.top.findNode("title").font = fonts().getExtraBold(20) 
end sub

sub onContentSet()
    if m.top.content <> invalid
       m.top.findNode("title").text = m.top.content.title
    end if
end sub
