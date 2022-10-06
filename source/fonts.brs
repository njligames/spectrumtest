' Copyright © 2022 by Intellectual Reserve, Inc. All rights reserved.
' Created by: James Folk

function fonts() as object
    m = {
        getBold: function(size) as dynamic
            font =  CreateObject("roSGNode", "Font")
            font.uri = "pkg:/images/fonts/OpenSans-Bold.ttf"
            font.size = size
            return font
        end function,

        getBoldItalic: function(size) as dynamic
            font =  CreateObject("roSGNode", "Font")
            font.uri = "pkg:/images/fonts/OpenSans-BoldItalic.ttf"
            font.size = size
            return font
        end function,

        getExtraBold: function(size) as dynamic
            font =  CreateObject("roSGNode", "Font")
            font.uri = "pkg:/images/fonts/OpenSans-ExtraBold.ttf"
            font.size = size
            return font
        end function,

        getExtraBoldItalic: function(size) as dynamic
            font =  CreateObject("roSGNode", "Font")
            font.uri = "pkg:/images/fonts/OpenSans-ExtraBoldItalic.ttf"
            font.size = size
            return font
        end function,

        getItalic: function(size) as dynamic
            font =  CreateObject("roSGNode", "Font")
            font.uri = "pkg:/images/fonts/OpenSans-Italic.ttf"
            font.size = size
            return font
        end function,

        getLight: function(size) as dynamic
            font =  CreateObject("roSGNode", "Font")
            font.uri = "pkg:/images/fonts/OpenSans-Light.ttf"
            font.size = size
            return font
        end function,

        getLightItalic: function(size) as dynamic
            font =  CreateObject("roSGNode", "Font")
            font.uri = "pkg:/images/fonts/OpenSans-LightItalic.ttf"
            font.size = size
            return font
        end function,

        getMedium: function(size) as dynamic
            font =  CreateObject("roSGNode", "Font")
            font.uri = "pkg:/images/fonts/OpenSans-Medium.ttf"
            font.size = size
            return font
        end function,

        getMediumItalic: function(size) as dynamic
            font =  CreateObject("roSGNode", "Font")
            font.uri = "pkg:/images/fonts/OpenSans-MediumItalic.ttf"
            font.size = size
            return font
        end function,

        getRegular: function(size) as dynamic
            font =  CreateObject("roSGNode", "Font")
            font.uri = "pkg:/images/fonts/OpenSans-Regular.ttf"
            font.size = size
            return font
        end function,

        getSemiBold: function(size) as dynamic
            font =  CreateObject("roSGNode", "Font")
            font.uri = "pkg:/images/fonts/OpenSans-SemiBold.ttf"
            font.size = size
            return font
        end function,

        getSemiBoldItalic: function(size) as dynamic
            font =  CreateObject("roSGNode", "Font")
            font.uri = "pkg:/images/fonts/OpenSans-SemiBoldItalic.ttf"
            font.size = size
            return font
        end function
    }

    return m
end function

