//
//  CustomView.swift
//  AppSpotLists
//
//  Created by GLB-253 on 12/5/18.
//  Copyright © 2018 IOSISFUN. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable class CustomView:UIView{
    
    @IBInspectable var cornerRadius:CGFloat = 0 {
        didSet {
            updateUI()
        }
    }
    
    @IBInspectable var firstLayerColor:UIColor = UIColor.white {
        didSet {
            updateUI()
        }
    }
    
    @IBInspectable var secondLayerColor:UIColor = UIColor.white {
        didSet {
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
     let layer = self.layer as! CAGradientLayer
     layer.colors = [firstLayerColor.cgColor,secondLayerColor.cgColor]
        
    }
    
    
}
