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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let uid = FIRAuth.auth()?.currentUser!.uid
        ref = FIRDatabase.database().reference(withPath: "business").child(uid!)
        ref!.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as! [String : Any]
            
            self.nameText.text = value["name"] as! String?
            self.addressText.text = value ["address"] as! String?
        })
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
