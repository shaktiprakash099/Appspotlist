//
//  CustomImageview.swift
//  AppSpotLists
//
//  Created by GLB-253 on 12/5/18.
//  Copyright © 2018 IOSISFUN. All rights reserved.
//

import UIKit

@IBDesignable class CustomImageView: UIImageView {
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet {
            updateUI()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet{
            updateUI()
        }
        
    }
    @IBInspectable var borderColor :UIColor = UIColor.clear{
        didSet{
            updateUI()
        }
    }
    
    
    func updateUI(){
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
}
