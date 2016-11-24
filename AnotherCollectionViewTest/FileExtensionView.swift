//
//  FileExtensionView.swift
//  DocumentsBasics
//
//  Created by Igor Galay on 21/11/2016.
//  Copyright © 2016 Rarus. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable
public class FileExtensionView: UIView {

    var ovalLayer : CAShapeLayer!
    var extensionLabel : UILabel!
    
    
    let lineWidth : CGFloat = 1.0
    
    @IBInspectable public var fillColor: UIColor = UIColor.red {
        didSet {
            updateFill()
        }
    }
    @IBInspectable public var extensionString: String = ".cmd" {
        didSet {
            updateLabel()
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        if ovalLayer == nil {
            ovalLayer = CAShapeLayer()
            layer.addSublayer(ovalLayer)
            
            let rect = bounds.insetBy(dx: lineWidth/2.0, dy: lineWidth/2.0)
            let path = UIBezierPath(ovalIn: rect)
            
            ovalLayer.path = path.cgPath
            ovalLayer.lineWidth = lineWidth
            ovalLayer.strokeColor = UIColor(red: 221.0/255.0, green: 221.0/255.0, blue: 221.0/255.0, alpha: 1.0).cgColor
            updateFill()
        }
        ovalLayer.frame = layer.bounds
        
        if extensionLabel == nil {
            extensionLabel = UILabel()
            extensionLabel.frame = self.bounds
            extensionLabel.preferredMaxLayoutWidth = 100.0
            extensionLabel.backgroundColor = UIColor.clear
            extensionLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.footnote)
            extensionLabel.textColor = UIColor.white
            extensionLabel.textAlignment = NSTextAlignment.center
            self.addSubview(extensionLabel)
        }
        updateLabel()
    }
    
    internal func cleanup() {
        self.ovalLayer.removeFromSuperlayer()
        self.ovalLayer = nil
        self.extensionLabel.removeFromSuperview()
        self.extensionLabel = nil
    }
    
    private func updateFill() {
        guard let ovalLayer = ovalLayer else { return }
        ovalLayer.fillColor = fillColor.cgColor
        
    }
    
    private func updateLabel() {
        guard let extensionLabel = extensionLabel else { return }
        extensionLabel.text = "." + extensionString
    }

}
