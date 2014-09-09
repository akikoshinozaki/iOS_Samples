//
//  GenerateXML.swift
//  1_3_ParseData
//
//  Created by 新居雅行 on 2014/08/08.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

import Foundation

@objc class GenerateXML: NSObject   {
    @objc func testGenerateXML()        {
        let bodyElement = GDataXMLElement.elementWithName("records")
        var parent = GDataXMLElement.elementWithName("record")
        var element = GDataXMLElement.elementWithName("name",
            stringValue: "My Name")
        parent.addChild(element)
        
        println(parent.elementsForName("name"))
        
        element = GDataXMLElement.elementWithName("ruby",
            stringValue: "My Name")
        parent.addChild(element)
        
        let xmlDoc = GDataXMLDocument(rootElement: bodyElement)
        xmlDoc.setCharacterEncoding("utf-8")
        
        println(xmlDoc.XMLData())
        println(bodyElement.XMLString())
        
        
/*
        GDataXMLElement *bodyElement = [GDataXMLElement elementWithName: @"records"];
        GDataXMLElement *element, *parent;
        parent = [GDataXMLElement elementWithName: @"record"];
        element = [GDataXMLElement elementWithName: @"name"
        stringValue: @"My Name"];
        [parent addChild: element];
        
        NSArray *x = [parent elementsForName: @"name"];
        NSLog(@"%@", x);
        
        element = [GDataXMLElement elementWithName: @"ruby"
        stringValue: @"My Name"];
        [parent addChild: element];
        [bodyElement addChild: parent];
        GDataXMLDocument *xmlDoc = [[GDataXMLDocument alloc] initWithRootElement: bodyElement];
        [xmlDoc setCharacterEncoding: @"utf-8"];
        
        NSLog(@"%@", [[NSString alloc] initWithData: [xmlDoc XMLData] encoding: NSUTF8StringEncoding]);
        NSLog(@"%@", [bodyElement XMLString]);
*/
    }
    
}