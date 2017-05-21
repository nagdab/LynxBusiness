//
//  SettingsViewController.swift
//  LynxBusiness
//
//  Created by Bhavik Nagda on 3/5/17.
//  Copyright © 2017 Yifan & Bhavik. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class SettingsViewController: UITableViewController {
 
    var ref: FIRDatabaseReference? = nil
    
    
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var addressText: UITextField!
    
    @IBOutlet weak var emailText: UILabel!
    @IBOutlet weak var newPwdText: UITextField!
    @IBOutlet weak var newPwdConfirmationText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let uid = FIRAuth.auth()?.currentUser!.uid
        print(FIRAuth.auth()?.currentUser!)
        ref = FIRDatabase.database().reference(withPath: "business").child(uid!)
        ref!.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as! [String : Any]
            
            self.nameText.text = value["name"] as! String?
            self.addressText.text = value ["address"] as! String?
        })
        self.emailText.text = FIRAuth.auth()?.currentUser!.email!
    }
    
    @IBAction func changePassword(_ sender: Any) {
        
        if newPwdText.text == newPwdConfirmationText.text && newPwdText.text != "" {
            
            FIRAuth.auth()?.currentUser!.updatePassword(newPwdText.text!) { error in
                if let error = error {
                    // An error happened.
                    let alert = UIAlertController(title: "Error",
                                                  message: error.localizedDescription,
                                                  preferredStyle: .alert)
                    
                    
                    let okayAction = UIAlertAction(title: "Okay",
                                                   style: .default)
                    
                    
                    
                    alert.addAction(okayAction)
                    
                    self.present(alert, animated: true, completion: nil)
                    
                } else {
                    let alert = UIAlertController(title: "Password Changed",
                                                   message: "The password change was successful.",
                                                   preferredStyle: .alert)
                    
                    
                    let okayAction = UIAlertAction(title: "Close",
                                                   style: .default)
                    
                    alert.addAction(okayAction)
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
        
        
    }
    
    
    @IBAction func nameEdited(_ sender: Any) {
        
        
    }
    
    
    @IBAction func signoutButtonPressed(_ sender: Any) {
        do {
            try FIRAuth.auth()?.signOut()
            dismiss(animated: true, completion: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
