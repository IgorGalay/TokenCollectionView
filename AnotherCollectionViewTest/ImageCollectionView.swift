//
//  ImageCollectionView.swift
//  CEOBoard
//
//  Created by Igor Galay on 11/15/16.
//  Copyright © 2016 1C-Rarus. All rights reserved.
//

import UIKit

private let imageDocumentCellIdentifier = "ImageDocumentCell"

protocol ImageCollectionViewDelegate : class {
    func preview(image : (String, UIImage))
    func deleteImage(at index: Int)
}

class ImageCollectionView: UICollectionView {

    fileprivate var images = [(String, UIImage)]() {
        didSet {
            reloadData()
            layoutIfNeeded()
        }
    }
    fileprivate weak var previewingDelegate: ImageCollectionViewDelegate?
    fileprivate var state : AttachedDocumentsPresentingState?
    
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
    internal func configure(with state: AttachedDocumentsPresentingState, images: [(String, UIImage)], delegate: ImageCollectionViewDelegate?) {
        self.state = state
        self.images = images
        self.previewingDelegate = delegate
    }
    
    // MARK: - Handy methods
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
    
    private func registerCells() {
        let nib = UINib(nibName: "ImageDocumentCollectionViewCell", bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: imageDocumentCellIdentifier)
    }
    
}

extension ImageCollectionView : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageDocumentCell", for: indexPath) as! ImageDocumentCollectionViewCell
        let image = images[indexPath.row].1
        cell.configure(with: image, delegate: self)
        self.setNeedsLayout()
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let state = state else { return }
        switch state {
        case .preview:
            previewingDelegate?.preview(image: images[indexPath.row])
        case .compose:
            let cell = collectionView.cellForItem(at: indexPath) as! ImageDocumentCollectionViewCell
            cell.attemptDelete()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            return self.collectionViewLayout.collectionViewContentSize
        }
    }
    
}

extension ImageCollectionView : ImageDocumentCollectionViewCellDelegate {
    func deleteRelatedImage(sender: ImageDocumentCollectionViewCell) {
        guard let indexPath = self.indexPath(for: sender) else { return }
        self.performBatchUpdates({ [weak self] in
            self?.images.remove(at: indexPath.row)
            self?.deleteItems(at: [indexPath])
        }, completion: nil)
        previewingDelegate?.deleteImage(at: indexPath.row)
    }
}
