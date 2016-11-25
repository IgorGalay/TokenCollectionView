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
    
    @IBOutlet weak var removeButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var removeButton: UIButton!
    
    var borderLayer : CAShapeLayer?
    let borderLineWidth : CGFloat = 1.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        let labelLeadingSpaceWidth : CGFloat = 10.0
        let maxAcceptableSize = UIScreen.main.bounds.width - removeButtonWidthConstraint.constant - fileExtensionView.frame.width - labelLeadingSpaceWidth - self.layoutMargins.left - self.layoutMargins.right
        let heightConstraint = NSLayoutConstraint(item: nameLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.lessThanOrEqual, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: maxAcceptableSize)
        heightConstraint.priority = 1000
        nameLabel.addConstraint(heightConstraint)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if borderLayer == nil {
            borderLayer = CAShapeLayer()
            let rect = self.layer.bounds.insetBy(dx: borderLineWidth/2.0, dy: borderLineWidth/2.0)
            let path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height/2)
            
            borderLayer?.path = path.cgPath
            borderLayer?.fillColor = UIColor(red: 249.0/255.0, green: 249.0/255.0, blue: 249.0/255.0, alpha: 1.0).cgColor
            borderLayer?.strokeColor = UIColor(red: 221.0/255.0, green: 221.0/255.0, blue: 221.0/255.0, alpha: 1.0).cgColor
            borderLayer?.lineWidth = borderLineWidth
            
            customContentView.layer.insertSublayer(borderLayer!, at: 0)
            customContentView.clipsToBounds = true
        }
    }
    
    public func configure(with fileName: String, type: SupportedFileFormat) {
        fileExtensionView.extensionString = type.rawValue
        if let color = type.color {
            fileExtensionView.fillColor = color
        }
        
        nameLabel.text = fileName
        nameLabel.sizeToFit()
    }
    
    func setup() {
//        removeButton.isHidden = true
//        removeButton.isUserInteractionEnabled = false
//        removeButtonWidthConstraint.constant /= 2
    }
    
    override func prepareForReuse() {
        borderLayer?.removeFromSuperlayer()
        borderLayer = nil
        nameLabel.text = nil
        fileExtensionView.cleanup()
        
    }

}
