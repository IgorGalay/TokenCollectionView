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
    
    internal func configure<PreviewingDelegate : ImageCollectionViewDelegate & DocumentsCollectionViewDelegate>(data: [String], images: [(String, UIImage)], previewingDelegate: PreviewingDelegate) {
        // TODO: separate images and other files here, and add data t ocollection views
        imagesCollectionView.testArray = images
        imagesCollectionView.previewingDelegate = previewingDelegate
        collectionView.items = data
        collectionView.previewingDelegate = previewingDelegate
    }

}
