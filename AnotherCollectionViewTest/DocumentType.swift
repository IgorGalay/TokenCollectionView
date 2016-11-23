//
//  DocumentType.swift
//  DocumentsBasics
//
//  Created by Igor Galay on 11/21/16.
//  Copyright © 2016 Rarus. All rights reserved.
//

import UIKit

enum DocumentType: String {
    
    case pdf
    case doc
    case docx
    case xls
    case xlsx
    case ppt
    case pptx
    case unknown
    
    init?(extensionString: String) {
        if let type = DocumentType(rawValue: extensionString) {
            self = type
        } else {
            self = .unknown
        }
    }
    
    var extensionString: String {
        return self.rawValue
    }
    
    var previewable : Bool {
        switch self {
        case .unknown:
            return false
        default:
            return true
        }
    }
    
    var color : UIColor {
        switch self {
        case .pdf:
            return UIColor.orange
        case .doc:
            return UIColor.blue
        case .docx:
            return UIColor.blue
        case .xls:
            return UIColor.green
        case .xlsx:
            return UIColor.green
        case .ppt:
            return UIColor.red
        case .pptx:
            return UIColor.red
        case .unknown:
            return UIColor.gray
        }
    }
    
}
