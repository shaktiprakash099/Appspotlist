//
//  ViewController.swift
//  AppSpotLists
//
//  Created by GLB-253 on 12/5/18.
//  Copyright © 2018 IOSISFUN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var diveInButton: CustomButton!
    @IBOutlet weak var userEmailTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkeloggedUserstatus()
      
    }
    func checkeloggedUserstatus(){
        
        let defaults = UserDefaults.standard
        if let useruseremail = defaults.object(forKey: "LoggedinUserEmailId"){
            self.performSegue(withIdentifier: "showitemlistVCsegue", sender: useruseremail)
        }
        
    }
    
    @IBAction func diveInAction(_ sender: Any) {
        
        guard let useremailString = self.userEmailTextfield.text?.trimmingCharacters(in: .whitespaces),useremailString.isemailValidated()  else {
            AlertManager.shareinstance.showAlert(on: self, alertmessageTitle: "Email id is required", alertmessageContent: "Kindly provide a valid emailid")
            return
        }
     
        let defaults = UserDefaults.standard
        defaults.set(useremailString, forKey: "LoggedinUserEmailId")
        self.performSegue(withIdentifier: "showitemlistVCsegue", sender: useremailString)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showitemlistVCsegue" {
            
            let itemVC = segue.destination as! ItemsListsViewController
            itemVC.loggedInUserEmailid = sender as? String
            
        }
    }
    
}

extension ViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

