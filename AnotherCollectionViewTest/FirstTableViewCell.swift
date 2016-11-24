//
//  FirstTableViewCell.swift
//  AnotherCollectionViewTest
//
//  Created by Igor Galay on 11/22/16.
//  Copyright © 2016 Rarus. All rights reserved.
//

import UIKit

class FirstTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: MainCollectionView!
    @IBOutlet weak var imagesCollectionView: ImageCollectionView!
    
    @IBOutlet weak var imageCollectionVIewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var HeightBetweenCollectionViewsConstraint: NSLayoutConstraint!
    
    
    internal func configure<PreviewingDelegate : ImageCollectionViewDelegate & DocumentsCollectionViewDelegate>(data: [String], images: [(String, UIImage)], previewingDelegate: PreviewingDelegate) {
        // TODO: separate images and other files here, and add data t ocollection views
        
        if images.count == 0 {
            collapseImageCollectionView()
        } else if imageCollectionVIewHeightConstraint.constant == 0.0 {
            presentImageCollectionView()
        }
        
        imagesCollectionView.testArray = images
        imagesCollectionView.previewingDelegate = previewingDelegate
        collectionView.items = data
        collectionView.previewingDelegate = previewingDelegate
    }
    
    private func collapseImageCollectionView() {
        imageCollectionVIewHeightConstraint.constant = 0.0
        HeightBetweenCollectionViewsConstraint.constant = 0.0
//        self.layoutIfNeeded()
    }
    
    private func presentImageCollectionView() {
        imageCollectionVIewHeightConstraint.constant = 100.0
        HeightBetweenCollectionViewsConstraint.constant = 8.0
//        self.layoutIfNeeded()
    }
    
    

}
