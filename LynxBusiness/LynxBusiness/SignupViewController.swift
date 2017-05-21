//
//  SignupViewController.swift
//  LynxBusiness
//
//  Created by Bhavik Nagda on 5/20/17.
//  Copyright © 2017 Yifan & Bhavik. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class SignupViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Address: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var PhotoChooser: UIButton!
    @IBOutlet weak var createAccount: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    }
    
    @IBAction func chooseImage(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        print("TESTER one")
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("TESTER two")
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            print("PICKED IMAGE")
        } else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("CANCELLED")
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func submitForm(_ sender: Any) {
        FIRAuth.auth()!.createUser(withEmail: Email.text!, password: Password.text!) { user, error in
                if error == nil {
                     print("WORKED")
                    let ref = FIRDatabase.database().reference(withPath: "business")
                    let businessRef = ref.child(user!.uid)
                    let newBusiness = Business(name: self.Name.text!, address: self.Address.text!, photoURL: "https://drpma142ptgxf.cloudfront.net/assets/logo.svg")
                    businessRef.setValue(newBusiness.toStorage())
                                        
                    FIRAuth.auth()!.signIn(withEmail: self.Email.text!, password: self.Password.text!)
                    self.performSegue(withIdentifier: "createdAccountSegue", sender: nil)
                }
                else {
                    
                    
                    
                    let alert = UIAlertController(title: "Error",
                                                  message: error?.localizedDescription,
                                                  preferredStyle: .alert)
                    
                    
                    let okayAction = UIAlertAction(title: "Okay",
                                                     style: .default)
                    

                    
                    alert.addAction(okayAction)
                    
                    self.present(alert, animated: true, completion: nil)

                    
                    print ("FAILED")
                    print (self.Email.text!)
                    print (self.Password.text!)
                }
        }

    }
    
    @IBAction func backButton(_ sender: Any) {
        self.performSegue(withIdentifier: "backToLogin", sender: nil)
    }
    
    
    
}
