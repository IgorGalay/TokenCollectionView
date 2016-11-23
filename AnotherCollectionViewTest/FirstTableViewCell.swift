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
    
    internal func configure(data: [String], images: [UIImage]) {
        // TODO: separate images and other files here, and add data t ocollection views
        imagesCollectionView.testArray = images
        collectionView.items = data
    }

}
