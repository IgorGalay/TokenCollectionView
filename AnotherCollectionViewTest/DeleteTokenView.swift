//
//  DeleteTokenView.swift
//  DocumentsBasics
//
//  Created by Igor Galay on 21/11/2016.
//  Copyright © 2016 Rarus. All rights reserved.
//

import UIKit

@IBDesignable
class DeleteTokenView: UIView {

    var crossLayer: CAShapeLayer!
    
    @IBInspectable var lineWidth : Double = 1.0 {
        didSet {
            updateAppearance()
        }
    }
    
    @IBInspectable var fillColor: UIColor = UIColor.darkGray {
        didSet {
            updateColors()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if crossLayer == nil {
            
            crossLayer = CAShapeLayer()
            crossLayer.frame = layer.bounds
            
            let path = UIBezierPath()
            let viewWidth = layer.frame.size.width
            
            path.move(to: CGPoint(x: 1/3 * viewWidth, y: 1/3 * viewWidth))
            path.addLine(to: CGPoint(x: 2/3 * viewWidth, y: 2/3 * viewWidth))
            path.move(to: CGPoint(x: 2/3 * viewWidth, y: 1/3 * viewWidth))
            path.addLine(to: CGPoint(x: 1/3 * viewWidth, y: 2/3 * viewWidth))
            
            crossLayer.path = path.cgPath
            
            updateColors()
            updateAppearance()
            
            layer.addSublayer(crossLayer)
        }
    }
    
    private func updateAppearance() {
        guard let crossLayer = crossLayer else { return }
        crossLayer.lineWidth = CGFloat(lineWidth)
    }
    
    private func updateColors() {
        guard let crossLayer = crossLayer else { return }
        crossLayer.fillColor = fillColor.cgColor
        crossLayer.strokeColor = fillColor.cgColor
    }

}
