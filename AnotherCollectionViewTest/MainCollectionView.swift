//
//  MainCollectionView.swift
//  AnotherCollectionViewTest
//
//  Created by Igor Galay on 11/22/16.
//  Copyright © 2016 Rarus. All rights reserved.
//

import UIKit

private let otherDocumentCellIdentifier = "TokenCollectionViewCell"

protocol DocumentsCollectionViewDelegate : class {
    func previewDocument(item : String)
    func showDocumentAddingOptions()
}

class MainCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {

    var items = [String]() {
        didSet {
            
            reloadData()
            layoutIfNeeded()
        }
    }
    
    weak var previewingDelegate: DocumentsCollectionViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let nib = UINib(nibName: "TokenCollectionViewCell", bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: otherDocumentCellIdentifier)
        
        let secondNib = UINib(nibName: "AddDocumentCollectionViewCell", bundle: nil)
        self.register(secondNib, forCellWithReuseIdentifier: "AddDocumentCollectionViewCell")

        
        collectionViewLayout = attachmentFlowLayout()
        dataSource = self
        delegate = self
        backgroundColor = UIColor.orange
//        self.layoutIfNeeded()
    }
    
    private func attachmentFlowLayout() -> UICollectionViewFlowLayout {
        let layout = CustomCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let estimatedWidth : CGFloat = 150
        let exactHeight : CGFloat = 40.0
        layout.estimatedItemSize = CGSize(width: estimatedWidth, height: exactHeight)
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        layout.minimumLineSpacing = 4.0
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < items.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: otherDocumentCellIdentifier, for: indexPath) as! TokenCollectionViewCell
            let documentType = indexPath.row % 2 == 0 ? SupportedFileFormat.ppt : SupportedFileFormat.doc
            cell.configure(with: items[indexPath.row], type: documentType)
            cell.setup()
            self.setNeedsLayout()
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddDocumentCollectionViewCell", for: indexPath) as! AddDocumentCollectionViewCell
            cell.delegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < items.count {
            previewingDelegate?.previewDocument(item: items[indexPath.row])
        } else {
            previewingDelegate?.showDocumentAddingOptions()
        }
    }
}

extension MainCollectionView : DocumentAdditionDelegate {
    internal func showDocumentAddingOptions() {
        previewingDelegate?.showDocumentAddingOptions()
    }
}
