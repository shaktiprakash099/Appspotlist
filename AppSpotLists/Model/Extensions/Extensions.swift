//
//  Extensions.swift
//  AppSpotLists
//
//  Created by GLB-253 on 12/5/18.
//  Copyright © 2018 IOSISFUN. All rights reserved.
//

import UIKit

extension String {
    
    func isemailValidated()-> Bool{
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        var valid = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
        if valid {
            valid = !self.contains("Invalid email id")
        }
        return valid
        
    }
}

extension UIImageView {
    func loadImage(from url: String?, placeHolder: UIImage?) {
        self.image = placeHolder
        if let url = url {
            guard let url = URL(string: url) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                self.image = UIImage(data: data)
            }.resume()
        }
    }
}
