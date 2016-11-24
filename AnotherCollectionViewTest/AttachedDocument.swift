//
//  AttachedDocument.swift
//  AnotherCollectionViewTest
//
//  Created by Igor Galay on 11/23/16.
//  Copyright © 2016 Rarus. All rights reserved.
//

import Foundation

class AttachedDocument {
    dynamic var name : String = ""
    dynamic var rawType : String = ""
    dynamic var url : String = ""
    dynamic var path : String?
    dynamic var size : Int = 0
}

struct AttachedDocumentStruct {
    
    let name : String
    let type : DocumentFileFormat
    let url : String
    let path : URL?
    let size : Int
    
    init(document : AttachedDocument) {
        self.name = document.name
        self.type = DocumentFileFormat(fileExtension: document.rawType)
        self.url = document.url
        self.size = document.size
        guard let path = document.path else { self.path = nil; return }
        self.path = URL(string: path) ?? nil
    }
    
}
