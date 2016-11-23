//
//  TokenCollectionViewCell.swift
//  DocumentsBasics
//
//  Created by Igor Galay on 11/18/16.
//  Copyright © 2016 Rarus. All rights reserved.
//

import UIKit

@IBDesignable
class TokenCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var customContentView: UIView!
    @IBOutlet weak var fileExtensionView: FileExtensionView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var borderLayer : CAShapeLayer?
    let borderLineWidth : CGFloat = 1.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if borderLayer == nil {
            borderLayer = CAShapeLayer()
            let rect = self.layer.bounds.insetBy(dx: borderLineWidth/2.0, dy: borderLineWidth/2.0)
            let path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height/2)
            
            borderLayer?.path = path.cgPath
            borderLayer?.fillColor = UIColor.lightGray.cgColor
            borderLayer?.strokeColor = UIColor.darkGray.cgColor
            borderLayer?.lineWidth = borderLineWidth
            
            customContentView.layer.insertSublayer(borderLayer!, at: 0)
            customContentView.clipsToBounds = true
        }
    }
    
    public func configure(with fileName: String, type: DocumentType) {
        fileExtensionView.extensionString = type.extensionString
        fileExtensionView.fillColor = type.color
        nameLabel.text = fileName
        nameLabel.sizeToFit()
        self.setNeedsLayout()
        self.setNeedsDisplay()
    }

}
