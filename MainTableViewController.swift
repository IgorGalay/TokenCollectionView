//
//  MainTableViewController.swift
//  AnotherCollectionViewTest
//
//  Created by Igor Galay on 11/22/16.
//  Copyright © 2016 Rarus. All rights reserved.
//

import UIKit
import QuickLook

class MainTableViewController: UITableViewController {

    var items = [String]()
    var testArray = [(String, UIImage)]()
    
    var fileURL : URL?
    
    let quickLookController = QLPreviewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let attachedDocumentsCellNib = UINib(nibName: "AttachedDocumentsTableViewCell", bundle: nil)
//        tableView.register(attachedDocumentsCellNib,  forCellReuseIdentifier: "AttachedDocumentsCell")
        
        items.append("1")
        items.append("22")
        items.append("333")
        items.append("4444")
        items.append("55555")
        items.append("1")
        items.append("2255555")
        items.append("333")
        items.append(" 4444")
        items.append("Lorem")
        items.append("Lor")
        items.append("Lor")
        items.append("Lorem")
        items.append("Lor")
        items.append("All")
        items.append("Final")
        
        if let first = UIImage(named: "1") {
            testArray.append(("1", first))
        }
        if let second = UIImage(named: "2") {
            testArray.append(("2", second))
        }
        if let third = UIImage(named: "3") {
            testArray.append(("3", third))
        }
        if let foth = UIImage(named: "4") {
            testArray.append(("4", foth))
        }
        if let fifth = UIImage(named: "5") {
            testArray.append(("5", fifth))
        }
        
        tableView.estimatedRowHeight = 300.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        quickLookController.dataSource = self
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! FirstTableViewCell
        cell.configure(data: items, images: testArray, previewingDelegate: self)
        return cell
    }
    
    @IBAction func printContentSize(_ sender: Any) {
        let cell = tableView.visibleCells[0] as! FirstTableViewCell
        print(cell.collectionView.collectionViewLayout.collectionViewContentSize)
        self.tableView.layoutIfNeeded()
        self.tableView.setNeedsDisplay()
    }

}

extension MainTableViewController : ImageCollectionViewDelegate, DocumentsCollectionViewDelegate {
    
    func preview(image : (String, UIImage)) {
        
        if let fileURL = Bundle.main.url(forResource: image.0, withExtension: "png") {
            if FileManager.default.fileExists(atPath: fileURL.path) {
                self.fileURL = fileURL
                if QLPreviewController.canPreview(fileURL as NSURL) {
                    quickLookController.currentPreviewItemIndex = 0
                    quickLookController.refreshCurrentPreviewItem()
                    navigationController?.pushViewController(quickLookController, animated: true)
                }
            }
        }
    }
    
    func previewDocument(item: String) {
        // ...
    }
    
}

extension MainTableViewController : QLPreviewControllerDataSource {
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return fileURL != nil ? 1 : 0
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        guard let fileURL = fileURL else { return NSURL(fileURLWithPath: "") }
        return fileURL as NSURL
    }
    
}
