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

class MainCollectionView: UICollectionView { // rename to AttachedDocumentsCollectionView

    fileprivate var documents = [String]() {
        didSet {
            reloadData()
            layoutIfNeeded()
        }
    }
    fileprivate weak var previewingDelegate: DocumentsCollectionViewDelegate?
    private var state: AttachedDocumentsPresentingState?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        registerCells()
        setup()
    }
    
    private func setup() {
        collectionViewLayout = attachmentFlowLayout()
        dataSource = self
        delegate = self
    }
    
    // MARK: - Configuration
    internal func configure(with state: AttachedDocumentsPresentingState, documents: [String], delegate: DocumentsCollectionViewDelegate?) {
        self.state = state
        self.documents = documents
        self.previewingDelegate = delegate
    }
    
    // MARK: - Handy methods
    private func registerCells() {
        let nib = UINib(nibName: "TokenCollectionViewCell", bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: otherDocumentCellIdentifier)
        
        let secondNib = UINib(nibName: "AddDocumentCollectionViewCell", bundle: nil)
        self.register(secondNib, forCellWithReuseIdentifier: "AddDocumentCollectionViewCell")
    }
    
    private func attachmentFlowLayout() -> UICollectionViewFlowLayout {
        let layout = CustomCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let estimatedWidth : CGFloat = 5
        let exactHeight : CGFloat = 40.0
        layout.estimatedItemSize = CGSize(width: estimatedWidth, height: exactHeight)
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        layout.minimumLineSpacing = 4.0
        layout.minimumInteritemSpacing = 8.0
        layout.headerReferenceSize = CGSize(width: 0.0, height: 0.0)
        layout.footerReferenceSize = CGSize(width: 0.0, height: 0.0)
        return layout
    }

}

extension MainCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return documents.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < documents.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: otherDocumentCellIdentifier, for: indexPath) as! TokenCollectionViewCell
            let documentType = indexPath.row % 2 == 0 ? SupportedFileFormat.ppt : SupportedFileFormat.doc
            cell.configure(with: documents[indexPath.row], type: documentType)
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
        if indexPath.row < documents.count {
            previewingDelegate?.previewDocument(item: documents[indexPath.row])
        } else {
            previewingDelegate?.showDocumentAddingOptions()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            // FIXME: Crutch
            if UIDevice.current.userInterfaceIdiom == .pad {
                let contentSize = self.collectionViewLayout.collectionViewContentSize
                return CGSize(width: contentSize.width/2.0, height: contentSize.height/2.0)
            }
            return self.collectionViewLayout.collectionViewContentSize
        }
    }
}

extension MainCollectionView : DocumentAdditionDelegate {
    internal func showDocumentAddingOptions() {
        previewingDelegate?.showDocumentAddingOptions()
    }
}
