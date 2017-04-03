//
//  CouponHistoryViewController.swift
//  LynxBusiness
//
//  Created by Bhavik Nagda on 3/20/17.
//  Copyright © 2017 Yifan & Bhavik. All rights reserved.
//

import Foundation
import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

class CouponHistoryViewContoller: UITableViewController
    {
        // firebase reference to the coupons
        let ref = FIRDatabase.database().reference(withPath: "coupon")
        
        // firebase reference to the businesses
        let businessRef = FIRDatabase.database().reference(withPath: "business")
    
        var coupons = [Coupon]()
        
        override func viewDidLoad()
        {
            super.viewDidLoad()
            print("view loaded")
            
            // set up the cell's height
            let statusBarHeight = UIApplication.shared.statusBarFrame.height
            let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
            tableView.contentInset = insets
            tableView.scrollIndicatorInsets = insets
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 65
            
            
            ref.observe(.value, with: { snapshot in
                
                var coupons = [Coupon]()
                if snapshot.exists()
                {
                    for item in snapshot.children
                    {
                        let snap = item as! FIRDataSnapshot
                        let coupon = Coupon(snapshot: snap)
                        // if coupon is not expired, add it to coupon list
                        if coupon.endDate > Date() && coupon.numbersLeft > 0
                        {
                            coupons.append(Coupon(snapshot: item as! FIRDataSnapshot))
                        }
                            // else delete it from the database
                        else
                        {
                            snap.ref.removeValue()
                        }
                    }
                    self.coupons = coupons
                    self.tableView.reloadData()
                }
                else
                {
                    print("no coupons yet")
                }
                
            })
            
            self.tableView.reloadData()
            
        }
        
        // function for number of cells in table
        override func tableView(_: UITableView, numberOfRowsInSection: Int) -> Int
        {
            return coupons.count

        }
    
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
        {
            if indexPath.section == 0
            {
                return 45.0
            }
            else
            {
                return 125.0
            }
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            guard let cell = tableView.cellForRow(at: indexPath) else { return }
            if indexPath.section == 0
            {
                let text = cell.textLabel!.text!
                // if the sorting option is not selected
                if cell.accessoryType == .none
                {
                    couponMaster.availableOptions[text] = couponMaster.options[text]
                    cell.accessoryType = .checkmark
                }
                else
                {
                    couponMaster.availableOptions[text] = nil
                    cell.accessoryType = .none
                }
            }
            else
            {
                let coupon = couponMaster.coupons[indexPath.row]
                if couponMaster.selected.contains(coupon)
                {
                    couponMaster.selected.remove(coupon)
                    print(couponMaster.selected)
                }
                else
                {
                    couponMaster.selected.insert(coupon)
                    print(couponMaster.selected)
                }
            }
            self.tableView.reloadData()
        }
        
        
        override func tableView(_ tableView: UITableView,
                                cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {
            // 0th section is for sorting options
            if indexPath.section == 0
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",
                                                         for: indexPath)
                cell.textLabel?.text = couponMaster.orderedOptions[indexPath.row]
                
                return cell
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CouponCell",
                                                     for: indexPath) as! CouponCell
            cell.cellSetUp()
            let coupon = couponMaster.sortedCoupons[indexPath.row]
            
            businessRef.child(coupon.businessID).observeSingleEvent(of: .value, with: { snapshot in
                let value = snapshot.value as! [String : Any]
                cell.businessName.text = value["name"] as? String
                let propicURL = URL(string: value["photoURL"] as! String)
                
                let session = URLSession(configuration: .default)
                
                let downloadPicTask = session.dataTask(with: propicURL!) { (data, response, error) in
                    // The download has finished.
                    if let e = error
                    {
                        print("Error downloading cat picture: \(e)")
                    }
                    else
                    {
                        // No errors found.
                        // It would be weird if we didn't have a response, so check for that too.
                        if let imageData = data
                        {
                            // Finally convert that Data into an image and do what you wish with it.
                            let image = UIImage(data: imageData)
                            // set the profile picture
                            cell.profilePic.image = image
                            cell.profilePic.contentMode = .scaleAspectFit
                        }
                        else
                        {
                            print("Couldn't get image: Image is nil")
                        }
                        
                    }
                }
                
                // resumes the download
                downloadPicTask.resume()
            })
            
            cell.numLeft.text = "\(coupon.numbersLeft)"
            cell.endDate.text = dateToString(dateData: coupon.endDate)
            cell.couponDescription.text = coupon.disc
            
            return cell
        }
    }
}
