//
//  CurrentAmount.swift
//  tips
//
//  Created by Perry Zheng on 8/29/14.
//  Copyright (c) 2014 Perry Zheng. All rights reserved.
//

import UIKit

class Bill: NSObject {
    var _rawAmount: String = ""
    
    func getRawAmount() -> String {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let tempAmount = userDefaults.objectForKey("RawAmount") as AnyObject! as! String!
        let lastRefreshDate = userDefaults.objectForKey("LastRefreshDate") as! NSDate!
        if (lastRefreshDate == nil) {
            return ""
        }
        let diffSec = (NSDate().timeIntervalSinceReferenceDate - lastRefreshDate.timeIntervalSinceReferenceDate)
        if (diffSec > 60) {
            self.setRawAmount("")
            return ""
        } else {
            return tempAmount
        }
    }
    
    private func synchronize() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(_rawAmount, forKey: "RawAmount")
        defaults.setObject(NSDate(), forKey: "LastRefreshDate")
        defaults.synchronize()
    }
    
    func setRawAmount(rawAmount: String)
    {
        self._rawAmount = rawAmount
        synchronize()
    }
}
