//
//  AddDocumentCollectionViewCell.swift
//  AnotherCollectionViewTest
//
//  Created by Igor Galay on 11/24/16.
//  Copyright © 2016 Rarus. All rights reserved.
//

import UIKit

class AddDocumentCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var customContentView: UIView!
    @IBOutlet weak var addButton: UIButton!
    
    var borderLayer : CAShapeLayer?
    let borderLineWidth : CGFloat = 1.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addButton.setTitle("Добавить", for: UIControlState.normal)
        addButton.sizeToFit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if borderLayer == nil {
            borderLayer = CAShapeLayer()
            let rect = self.layer.bounds.insetBy(dx: borderLineWidth/2.0, dy: borderLineWidth/2.0)
            let path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height/2)
            
            borderLayer?.path = path.cgPath
            borderLayer?.fillColor = UIColor(red: 249.0/255.0, green: 249.0/255.0, blue: 249.0/255.0, alpha: 1.0).cgColor
            borderLayer?.strokeColor = UIColor(red: 221.0/255.0, green: 221.0/255.0, blue: 221.0/255.0, alpha: 1.0).cgColor
            borderLayer?.lineWidth = borderLineWidth
            
            customContentView.layer.insertSublayer(borderLayer!, at: 0)
            customContentView.clipsToBounds = true
        }
    }

    @IBAction func addDocument(_ sender: UIButton) {
        print("Add document action here")
    }
    
}
