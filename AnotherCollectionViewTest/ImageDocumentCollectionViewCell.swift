//
//  ImageDocumentCollectionViewCell.swift
//  CEOBoard
//
//  Created by Igor Galay on 11/15/16.
//  Copyright © 2016 1C-Rarus. All rights reserved.
//

import UIKit

typealias ImageURL = URL
typealias ImagePath = String

class ImageDocumentCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true
        backgroundColor = UIColor.clear
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    internal func configure(with image: UIImage) {
        imageView.image = image
        self.setNeedsLayout()
        self.setNeedsDisplay()
    }
    
    
    
//    internal func configure(with imageURL: ImageURL) {
//        imageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "nophoto-icon"))
//    }

}
