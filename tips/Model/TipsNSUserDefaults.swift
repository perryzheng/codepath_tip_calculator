//
//  CurrentAmount.swift
//  tips
//
//  Created by Perry Zheng on 8/29/14.
//  Copyright (c) 2014 Perry Zheng. All rights reserved.
//

import UIKit

class TipsNSUserDefaults: NSObject {
    var rawAmount: String = ""
    
    func getRawAmount() -> String {
        var userDefaults = NSUserDefaults.standardUserDefaults()
        let tempAmount = userDefaults.objectForKey("RawAmount") as AnyObject! as String!
        if (tempAmount.isEmpty) {
            return rawAmount
        }
        let lastRefreshDate = userDefaults.objectForKey("LastRefreshDate") as NSDate
        let diffMs = (NSDate().timeIntervalSinceReferenceDate - lastRefreshDate.timeIntervalSinceReferenceDate)
        if (diffMs > 1) {
            println("diffMs=")
            println(diffMs)
            self.setRawAmount("")
            println("rawAmountNow=" + rawAmount)
            return ""
        } else {
            return tempAmount
        }
    }
    
    private func synchronize() {
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(rawAmount, forKey: "RawAmount")
        defaults.setObject(NSDate(), forKey: "LastRefreshDate")
        defaults.synchronize()
    }
    
    func setRawAmount(rawAmount: String)
    {
        self.rawAmount = rawAmount
        synchronize()
    }
}
