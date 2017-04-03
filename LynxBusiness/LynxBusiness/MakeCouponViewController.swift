//
//  MakeCouponViewController.swift
//  LynxBusiness
//
//  Created by Bhavik Nagda on 3/6/17.
//  Copyright © 2017 Yifan & Bhavik. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class MakeCouponViewController: UITableViewController{
    
    
    
    @IBOutlet weak var discountText: UITextField!
    @IBOutlet weak var totalText: UITextField!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var endDate: UIDatePicker!
    @IBOutlet weak var submitButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func submitCoupon(_ sender: Any) {
        let uid = FIRAuth.auth()?.currentUser!.uid
        
        
        let coupon = Coupon(businessID: uid!, numbersLeft: Int(totalText.text!)!, endDate: endDate.date, discount: discountText.text!, disc: descriptionText.text!)
        
        let ref = FIRDatabase.database().reference(withPath: "coupon")
        
        let couponRef = ref.child(dateToString(dateData: coupon.endDate))
        
        couponRef.setValue(coupon.toStorage())
        
        self.performSegue(withIdentifier: "submitCoupon", sender: nil)
        
    }
}
