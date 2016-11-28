//
//  FirstTableViewCell.swift
//  AnotherCollectionViewTest
//
//  Created by Igor Galay on 11/22/16.
//  Copyright © 2016 Rarus. All rights reserved.
//

import UIKit

enum AttachedDocumentsPresentingState {
    case preview
    case compose
}

let kImagesCollectionViewHeight: CGFloat = 100.0
let kSpaceBetweenCollectionViews: CGFloat = 8.0


class FirstTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: MainCollectionView! // rename to documentsCollectionView
    @IBOutlet weak var imagesCollectionView: ImageCollectionView!
    
    @IBOutlet weak var imageCollectionVIewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var HeightBetweenCollectionViewsConstraint: NSLayoutConstraint!
    
//    private var state: AttachedDocumentCellState = .preview //default
    
    
    internal func configure<PreviewingDelegate : ImageCollectionViewDelegate & DocumentsCollectionViewDelegate>(with state: AttachedDocumentsPresentingState, data: [String], images: [(String, UIImage)], previewingDelegate: PreviewingDelegate) {
        // TODO: separate images and other files here, and add data t ocollection views
        setupImagesCollectionView(imagesCount: images.count)
        
        imagesCollectionView.configure(with: state, images: images, delegate: previewingDelegate)
        collectionView.configure(with: state, documents: data, delegate: previewingDelegate)
    }
    
    private func setupImagesCollectionView(imagesCount: Int) {
        imageCollectionVIewHeightConstraint.constant = (imagesCount != 0 && imageCollectionVIewHeightConstraint.constant != 0.0) ? kImagesCollectionViewHeight : 0.0
        HeightBetweenCollectionViewsConstraint.constant = (imagesCount != 0 && imageCollectionVIewHeightConstraint.constant != 0.0) ? kSpaceBetweenCollectionViews : 0.0
    }
    
    override func prepareForReuse() {
        self.layoutIfNeeded()
    }

}
