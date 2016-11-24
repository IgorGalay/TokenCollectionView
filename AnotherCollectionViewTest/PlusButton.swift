//
//  PlusButton.swift
//  AnotherCollectionViewTest
//
//  Created by Igor Galay on 11/24/16.
//  Copyright © 2016 Rarus. All rights reserved.
//

import UIKit

class PlusButton: UIButton {

    var ovalLayer : CAShapeLayer!
    
    let lineWidth : CGFloat = 1.0
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if ovalLayer == nil {
            ovalLayer = CAShapeLayer()
            layer.addSublayer(ovalLayer)
            
            let rect = bounds.insetBy(dx: lineWidth/2.0, dy: lineWidth/2.0)
            let path = UIBezierPath(ovalIn: rect)
            
            ovalLayer.path = path.cgPath
            ovalLayer.lineWidth = lineWidth
            ovalLayer.strokeColor = UIColor(red: 221.0/255.0, green: 221.0/255.0, blue: 221.0/255.0, alpha: 1.0).cgColor
            ovalLayer.fillColor = UIColor.clear.cgColor
        }
        ovalLayer.frame = layer.bounds
    }
    
    internal func cleanup() {
        self.ovalLayer.removeFromSuperlayer()
        self.ovalLayer = nil
    }

}
