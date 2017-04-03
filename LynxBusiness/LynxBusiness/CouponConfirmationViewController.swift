//
//  NewCouponViewController.swift
//  LynxBusiness
//
//  Created by Bhavik Nagda on 3/20/17.
//  Copyright © 2017 Yifan & Bhavik. All rights reserved.
//

import Foundation
import UIKit

class CouponConfirmationViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBAction func backPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "backButton", sender: nil)
    }
    
}
