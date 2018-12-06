//
//  CustomButton.swift
//  AppSpotLists
//
//  Created by GLB-253 on 12/5/18.
//  Copyright © 2018 IOSISFUN. All rights reserved.
//

import Foundation
import  UIKit
@IBDesignable class CustomButton:UIButton {
    
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet {
           updateUI()
        }
    }
    
    @IBInspectable var firstColor:UIColor = UIColor.clear {
        didSet {
            updateUI()
        }
    }
    @IBInspectable var secondColor:UIColor = UIColor.clear {
        didSet{
            updateUI()
        }
    }
    
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    func updateUI(){
        self.layer.cornerRadius = cornerRadius
        let gradient: CAGradientLayer = self.layer as! CAGradientLayer
        gradient.frame = self.bounds
        gradient.colors = [firstColor,secondColor].map { $0.cgColor }
        gradient.locations = [0.0,1.0]
        gradient.startPoint =  CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        
    }
}
