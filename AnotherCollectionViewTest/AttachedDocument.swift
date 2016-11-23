//
//  AttachedDocument.swift
//  AnotherCollectionViewTest
//
//  Created by Igor Galay on 11/23/16.
//  Copyright © 2016 Rarus. All rights reserved.
//

import Foundation

class AttachedDocument {
    
    let name : String = ""
    let rawType : String = ""
    let url : String = ""
    let size : Int = 0

}

struct AttachedDocumentStruct {
    
    let name : String
    let type : DocumentType
    let url : String
    let size : Int
    
    init(document : AttachedDocument) {
        self.name = document.name
        if let validType = DocumentType(extensionString: document.rawType) {
            self.type = validType
        } else {
            self.type = DocumentType.unknown
        }
        self.url = document.url
        self.size = document.size
    }
    
}
