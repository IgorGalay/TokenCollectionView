//
//  MainCollectionView.swift
//  AnotherCollectionViewTest
//
//  Created by Igor Galay on 11/22/16.
//  Copyright © 2016 Rarus. All rights reserved.
//

import UIKit

private let otherDocumentCellIdentifier = "TokenCollectionViewCell"

class MainCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {

    var items = [String]() {
        didSet {
            reloadData()
            layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let nib = UINib(nibName: "TokenCollectionViewCell", bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: otherDocumentCellIdentifier)

        
        collectionViewLayout = attachmentFlowLayout()
        dataSource = self
        delegate = self
//        backgroundColor = UIColor.orange
//        self.layoutIfNeeded()
    }
    
    private func attachmentFlowLayout() -> UICollectionViewFlowLayout {
        let layout = CustomCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize(width: 100.0, height: 100.0)
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        layout.minimumLineSpacing = 4.0
        layout.minimumInteritemSpacing = 8.0
        layout.headerReferenceSize = CGSize(width: 0.0, height: 0.0)
        layout.footerReferenceSize = CGSize(width: 0.0, height: 0.0)
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: otherDocumentCellIdentifier, for: indexPath) as! TokenCollectionViewCell
        let documentType = indexPath.row % 2 == 0 ? DocumentType.ppt : DocumentType.doc
        cell.configure(with: items[indexPath.row], type: documentType)
        self.setNeedsLayout()
        return cell
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            return self.collectionViewLayout.collectionViewContentSize
        }
    }

}
