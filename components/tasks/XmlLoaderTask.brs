' Copyright © 2022 by Intellectual Reserve, Inc. All rights reserved.
' Created by: James Folk

sub Init()
    m.top.functionName = "GetContent"
end sub

sub GetContent()


    rootChildren = []

    row = {}
    row.title = "Terms"
    row.children = []
    item = {}
    item.data = GetTermsText("eng")
    row.children.Push(item)
    rootChildren.Push(row)

    row = {}
    row.title = "Privacy"
    row.children = []
    item = {}
    item.data = GetPrivacyText("eng")
    row.children.Push(item)
    rootChildren.Push(row)

    contentNode = CreateObject("roSGNode", "ContentNode")
    contentNode.Update({
        children: rootChildren
    }, true)
    m.top.content = contentNode
end sub

function GetTermsText(lang as string)
    url = "https://www.lds.org/legal/terms-of-use?lang=" + lang + "&country=go&format=xml"
    responseXML = GetContentFeed(url)
    if responseXML <> invalid
        return StringRemoveHTMLTags(responseXML.block[1].GenXML(false))
    end if
    return ""
end function

function GetPrivacyText(lang as string)
    url = "https://www.lds.org/legal/privacy-notice?lang=" + lang + "&country=go&format=xml"
    responseXML = GetContentFeed(url)
    if responseXML <> invalid
        return StringRemoveHTMLTags(responseXML.block[1].GenXML(false))
    end if
    return ""
end function

function ParseXMLContent(list As Object) 'Formats content into content nodes so they can be passed into the RowList
    RowItems = createObject("RoSGNode","ContentNode")
    'Content node format for RowList: ContentNode(RowList content) --<Children>-> ContentNodes for each row --<Children>-> ContentNodes for each item in the row)
    for each rowAA in list
        row = createObject("RoSGNode","ContentNode")
        row.Title = rowAA.Title

        for each itemAA in rowAA.ContentList
            item = createObject("RoSGNode","ContentNode")
            item.SetFields(itemAA)
            row.appendChild(item)
        end for
        RowItems.appendChild(row)
    end for
    return RowItems
end function

function ParseXML(str As String) As dynamic 'Takes in the content feed as a string
    if str = invalid then return invalid  'if the response is invalid, return invalid
    xml = CreateObject("roXMLElement") '
    if not xml.Parse(str) then return invalid 'If the string cannot be parsed, return invalid
    return xml 'returns parsed XML if not invalid
end function

function FetchXmlContent(url as string)
    port = CreateObject("roMessagePort")
    request = CreateObject("roUrlTransfer")
    request.SetMessagePort(port)
    request.SetUrl(url)
    request.SetCertificatesFile("common:/certs/ca-bundle.crt")
    request.AsyncGetToString()
    msg = wait(0, port)
    body = ""

    if type(msg) = "roUrlEvent"
        statusCode = msg.GetResponseCode()
        body = msg.GetString()
        if statusCode <> 200
            throw { number: statusCode, message: msg.GetFailureReason()}
        end if
    end if

    return body
end function


function StringRemoveHTMLTags(baseStr as String) as String
    r = createObject("roRegex", "<[^<]+?>", "i")
    return r.replaceAll(baseStr, "")
end function

function GetContentFeed(url as string) 'This function retrieves and parses the feed and stores each content item in a ContentNode
    body = ""
    try
        body = FetchXmlContent(url)
    catch e
        print "error"
        return ""
    end try

    return ParseXML(body)
end function