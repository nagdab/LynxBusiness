//
//  CouponHistoryCell.swift
//  LynxBusiness
//
//  Created by Bhavik Nagda on 5/20/17.
//  Copyright © 2017 Yifan & Bhavik. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase


class CouponHistoryCell: UITableViewCell
{
    var coupon : Coupon!
    
    @IBOutlet weak var desc: UILabel!
    
    @IBOutlet weak var numRemaining: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var usedCoupons: UILabel!
    
    @IBAction func use(_ sender: Any)
    {
        coupon.numbersLeft -= 1
        coupon.ref?.updateChildValues(coupon.toStorage())
    }
    
    

    @IBAction func deleteCoupon(_ sender: Any)
    {
        coupon.ref?.removeValue()
    }

}
