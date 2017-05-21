//
//  CouponHistoryController.swift
//  LynxBusiness
//
//  Created by Bhavik Nagda on 5/20/17.
//  Copyright © 2017 Yifan & Bhavik. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase



class CouponHistoryController: UITableViewController
{
    
    var coupons = [Coupon]()
    
    // firebase reference to the coupons
    let ref = FIRDatabase.database().reference(withPath: "coupon")
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        ref.observe(.value, with: { snapshot in
            var newCoupons = [Coupon]()
            if snapshot.exists()
            {
                for item in snapshot.children
                {
                    let snap = item as! FIRDataSnapshot
                    let coupon = Coupon(snapshot: snap)
                    // if coupon is not expired, add it to coupon list
                    if coupon.endDate > Date() && coupon.numbersLeft > 0 && coupon.businessID == FIRAuth.auth()?.currentUser!.uid
                    {
                        newCoupons.append(coupon)
                    }
                }
            }
            else
            {
                print("no coupons yet")
            }
            self.coupons = newCoupons
            self.tableView.reloadData()
            
        })
    }
    
    override func tableView(_: UITableView, numberOfRowsInSection: Int) -> Int
    {
        return coupons.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CouponHistory",
                                                 for: indexPath) as! CouponHistoryCell
        let coupon = coupons[indexPath.row]
        print(coupon)
        
        cell.discription.text = coupon.disc
        cell.date.text = dateToString(dateData: coupon.endDate)
        cell.numRemaining.text = String(coupon.numbersLeft)
        cell.coupon = coupon
        
        return cell
    }
    
}
