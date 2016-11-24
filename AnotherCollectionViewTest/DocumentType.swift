//
//  DocumentType.swift
//  DocumentsBasics
//
//  Created by Igor Galay on 11/21/16.
//  Copyright © 2016 Rarus. All rights reserved.
//

import UIKit

struct DocumentFileFormat {
    
    let fileExtension: String
    
    var previewable : Bool {
        if SupportedFileFormat(extensionString: fileExtension) != nil {
            return true
        }
        return false
    }
    
    var associatedColor : UIColor {
        if let supportedType = SupportedFileFormat(extensionString: fileExtension) {
            return supportedType.color ?? UIColor.lightGray
        }
        return UIColor.lightGray
    }
    
    var isImageFormat : Bool {
        if let format = SupportedFileFormat(extensionString: fileExtension) {
            return format.isImage
        }
        return false
    }
    
}

enum SupportedFileFormat: String {
    
    // Images
    case jpg
    case jpeg
    case png
    
    // iWork docs
    case pages
    case key
    case numbers
    
    // MS office docs
    case doc
    case docx
    case xls
    case xlsx
    case ppt
    case pptx
    
    // Other
    case pdf
    case csv
    case txt
    case rtf

    case unknown
    
    init?(extensionString: String) {
        if let type = SupportedFileFormat(rawValue: extensionString) {
            self = type
        }
        return nil
    }
    
    var isImage : Bool {
        switch self {
        case .jpg, .jpeg, .png:
            return true
        default:
            return false
        }
    }
    
    var color : UIColor? {
        switch self {
        // Images
        case .jpg, .jpeg, .png, .unknown:
            return nil
            
        // iWork docs
        case .pages:
            return UIColor.cyan
        case .key:
            return UIColor.orange
        case .numbers:
            return UIColor.yellow
            
        // MS office docs
        case .doc, .docx:
            return UIColor.blue
        case .xls, .xlsx:
            return UIColor.green
        case .ppt, .pptx:
            return UIColor.red
            
        // Other
        case .pdf, .csv, .txt, .rtf :
            return UIColor.red
        }
    }
    
}
