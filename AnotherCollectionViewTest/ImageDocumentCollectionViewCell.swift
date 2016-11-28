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

protocol ImageDocumentCollectionViewCellDelegate: class {
    func deleteRelatedImage(sender: ImageDocumentCollectionViewCell)
}

enum ImageDocumentCellState {
    case `default`
    case selected
}

class ImageDocumentCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var maskImageView: UIImageView!
    
    private weak var delegate: ImageDocumentCollectionViewCellDelegate?
    private var state : ImageDocumentCellState = .default
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupAppearance()
    }
    
    private func setupAppearance() {
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
    
    internal func configure(with image: UIImage, delegate: ImageDocumentCollectionViewCellDelegate) {
        imageView.image = image
        self.delegate = delegate
        self.setNeedsLayout()
        self.setNeedsDisplay()
    }
    
    func attemptDelete() {
        switch state {
        case .default:
            state = .selected
            maskImageView.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.25, execute: { [weak self] in
                UIView.animate(withDuration: 0.25, animations: { [weak self] in
                    self?.maskImageView.alpha = 0.0
                }, completion: { [weak self] (_) in
                    self?.state = .default
                    self?.maskImageView.isHidden = true
                    self?.maskImageView.alpha = 0.7
                })
            })
        case .selected:
            delegate?.deleteRelatedImage(sender: self)
        }
    }
    
//    internal func configure(with imageURL: ImageURL) {
//        imageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "nophoto-icon"))
//    }

}
