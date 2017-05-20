//
//  LoginViewController.swift
//  LynxBusiness
//
//  Created by Bhavik Nagda on 2/23/17.
//  Copyright © 2017 Yifan & Bhavik. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    let loginToMain = "LoginToMain"

    
    @IBOutlet weak var LoginEmail: UITextField!
    @IBOutlet weak var LoginPassword: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1
   /*     FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
            // 2
            if user != nil {
                // 3
                print("Hi")
                self.performSegue(withIdentifier: self.loginToMain, sender: nil)
            }
        } */
    }
    
    @IBAction func loginDidTouch(_ sender: Any) {
        FIRAuth.auth()!.signIn(withEmail: LoginEmail.text!, password: LoginPassword.text!) {(user, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error",
                                              message: error?.localizedDescription,
                                              preferredStyle: .alert)
                
                
                let okayAction = UIAlertAction(title: "Okay",
                                               style: .default)
                
                
                
                alert.addAction(okayAction)
                
                self.present(alert, animated: true, completion: nil)
                
                
            }
            else if user != nil {
                print("NOT NIL")
                self.performSegue(withIdentifier: self.loginToMain, sender: nil)
            }
        }
    }
    
    
    
    
    @IBAction func signUpDidTouch(_ sender: Any) {
        performSegue(withIdentifier: "signupSegue", sender: nil)
/*        let alert = UIAlertController(title: "Register",
                                      message: "Register",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            // 1
            let nameField = alert.textFields![0]
            let addressField = alert.textFields![1]
            let photoURLField = alert.textFields![2]
            
            let emailField = alert.textFields![3]
            let passwordField = alert.textFields![4]
            
            // 2
            FIRAuth.auth()!.createUser(withEmail: emailField.text!,
                                       password: passwordField.text!) { user, error in
                                        if error == nil {
                                            // 3
                                            print("WORKED")
                                            
                                            let ref = FIRDatabase.database().reference(withPath: "business")
                                            
                                            let businessRef = ref.child(user!.uid)
                                            
                                            let newBusiness = Business(name: nameField.text!, address: addressField.text!, photoURL: photoURLField.text!)
                                            
                                            
                                            businessRef.setValue(newBusiness.toStorage())
                                            
                                            
                                            
                                            
                                            
                                            FIRAuth.auth()!.signIn(withEmail: self.LoginEmail.text!,
                                                                   password: self.LoginPassword.text!)
                                        }
                                        else {
                                            print ("FAILED")
                                            print (emailField.text!)
                                            print (passwordField.text!)
                                        }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField { textName in
            textName.placeholder = "Enter your business name"
        }
        
        alert.addTextField { textAddress in
            textAddress.placeholder = "Enter your business address"
        }
        
        alert.addTextField { textPhotoURL in
            textPhotoURL.placeholder = "Enter your business photo URL"
        }
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil) */
    }
    

    }

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == LoginEmail {
            LoginPassword.becomeFirstResponder()
        }
        if textField == LoginPassword {
            textField.resignFirstResponder()
        }
        return true
    }
    
}
