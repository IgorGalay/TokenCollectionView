//
//  ImageCollectionView.swift
//  CEOBoard
//
//  Created by Igor Galay on 11/15/16.
//  Copyright © 2016 1C-Rarus. All rights reserved.
//

import UIKit

private let imageDocumentCellIdentifier = "ImageDocumentCell"

class ImageCollectionView: UICollectionView {

    var testArray = [UIImage]() {
        didSet {
            reloadData()
            layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let nib = UINib(nibName: "ImageDocumentCollectionViewCell", bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: imageDocumentCellIdentifier)

        collectionViewLayout = attachmentFlowLayout()
        dataSource = self
        delegate = self
//        self.layoutIfNeeded()
    }
    
    private func attachmentFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100.0, height: 100.0)
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        layout.minimumLineSpacing = 8.0
        layout.minimumInteritemSpacing = 8.0
        layout.headerReferenceSize = CGSize(width: 0.0, height: 0.0)
        layout.footerReferenceSize = CGSize(width: 0.0, height: 0.0)
        return layout
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            return self.collectionViewLayout.collectionViewContentSize
        }
    }
    
//    internal func configure(with images: [UIImage]) {
//        self.images = images
//    }
    
}

extension ImageCollectionView : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageDocumentCell", for: indexPath) as! ImageDocumentCollectionViewCell
        let image = testArray[indexPath.row]
        cell.configure(with: image)
        self.setNeedsLayout()
        return cell
        
    }
    
}
