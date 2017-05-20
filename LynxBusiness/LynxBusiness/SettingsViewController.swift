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
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var newPwdText: UITextField!
    @IBOutlet weak var newPwdConfirmationText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let uid = FIRAuth.auth()?.currentUser!.uid
        ref = FIRDatabase.database().reference(withPath: "business").child(uid!)
        ref!.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as! [String : Any]
            
            self.nameText.text = value["name"] as! String?
            self.addressText.text = value ["address"] as! String?
            self.emailText.text = FIRAuth.auth()?.currentUser!.email!
        })
    }
    
    @IBAction func changePassword(_ sender: Any) {
        
 /*       if newPwdText.text == newPwdConfirmationText.text != "" {
            let credential = FIREmailPasswordAuthProvider.credentialWithEmail((FIRAuth.auth()?.currentUser!.email!)!, password: newPwdText.text!)
            
            user?.reauthenticateWithCredential(credential) { error in
                if let error = error {
                    // An error happened.
                } else {
                    // User re-authenticated.
                }
            }
        } */
        
        
        
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
