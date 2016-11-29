//
//  TokenCollectionViewCell.swift
//  DocumentsBasics
//
//  Created by Igor Galay on 11/18/16.
//  Copyright © 2016 Rarus. All rights reserved.
//

import UIKit

protocol TokenCollectionViewCellDelegate : class {
    func deleteRelatedDocument(sender: UICollectionViewCell)
}


let kDeleteButtonWidth : CGFloat = 40.0

class TokenCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var customContentView: UIView!
    @IBOutlet weak var fileExtensionView: FileExtensionView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var removeButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var removeButton: UIButton!
    
    private var borderLayer : CAShapeLayer?
    private let borderLineWidth : CGFloat = 1.0
    
    private weak var delegate : TokenCollectionViewCellDelegate?
    
    
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
    
    internal func configure(with fileName: String, type: SupportedFileFormat, state: AttachedDocumentsPresentingState?, delegate: TokenCollectionViewCellDelegate) {
        fileExtensionView.extensionString = type.rawValue
        if let color = type.color {
            fileExtensionView.fillColor = color
        }
        setup(with: state)
        self.delegate = delegate
        nameLabel.text = fileName
        self.setNeedsLayout()
    }
    
    private func setup(with state: AttachedDocumentsPresentingState?) {
        guard let state = state else { return }
        removeButton.isHidden = state == .preview ? true : false
        removeButton.isUserInteractionEnabled = state == .preview ? false : true
        removeButtonWidthConstraint.constant = state == .preview ? kDeleteButtonWidth/2 : kDeleteButtonWidth
    }
    
    @IBAction func deleteDocument(_ sender: UIButton) {
        if let cell = sender.superview?.superview?.superview as? UICollectionViewCell {
            delegate?.deleteRelatedDocument(sender: cell)
        }
    }
    
    override func prepareForReuse() {
        borderLayer?.removeFromSuperlayer()
        borderLayer = nil
        nameLabel.text = nil
        nameLabel.layoutIfNeeded()
        fileExtensionView.cleanup()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        return attributes
    }

}
