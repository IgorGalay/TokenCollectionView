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
    @IBOutlet weak var maskImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        
        imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true
        maskImageView.layer.cornerRadius = 8.0
        maskImageView.clipsToBounds = true
        maskImageView.isHidden = true
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        maskImageView.isHidden = true
    }
    
    internal func configure(with image: UIImage) {
        imageView.image = image
        self.setNeedsLayout()
        self.setNeedsDisplay()
    }
    
    func attemptDelete() {
        if maskImageView.isHidden {
            maskImageView.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.25, execute: { [weak self] in
                UIView.animate(withDuration: 0.25, animations: { [weak self] in
                    self?.maskImageView.alpha = 0.0
                }, completion: { [weak self] (_) in
                    self?.maskImageView.isHidden = true
                    self?.maskImageView.alpha = 0.7
                })
            })
        } else {
            print("Delete")
        }
    }
    
//    internal func configure(with imageURL: ImageURL) {
//        imageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "nophoto-icon"))
//    }

}
