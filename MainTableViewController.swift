//
//  MainTableViewController.swift
//  AnotherCollectionViewTest
//
//  Created by Igor Galay on 11/22/16.
//  Copyright © 2016 Rarus. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    var items = [String]()
    var testArray = [UIImage]()
    
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
        
        if let first = UIImage(named: "boss") {
            testArray.append(first)
        }
        if let second = UIImage(named: "dubldom") {
            testArray.append(second)
        }
        if let third = UIImage(named: "schema") {
            testArray.append(third)
        }
        if let foth = UIImage(named: "boss") {
            testArray.append(foth)
        }
        if let fifth = UIImage(named: "dubldom") {
            testArray.append(fifth)
        }
        
        tableView.estimatedRowHeight = 300.0
        tableView.rowHeight = UITableViewAutomaticDimension
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
        cell.configure(data: items, images: testArray)
        return cell
    }
    
    @IBAction func printContentSize(_ sender: Any) {
        let cell = tableView.visibleCells[0] as! FirstTableViewCell
        print(cell.collectionView.collectionViewLayout.collectionViewContentSize)
        self.tableView.layoutIfNeeded()
        self.tableView.setNeedsDisplay()
    }

}
