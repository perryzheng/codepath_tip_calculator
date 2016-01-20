//
//  CurrentAmount.swift
//  tips
//
//  Created by Perry Zheng on 8/29/14.
//  Copyright (c) 2014 Perry Zheng. All rights reserved.
//

import UIKit

class Utils {
    // number of seconds before we refresh the last saved raw amount
    static let DefaultSecondsBeforeRefreshing = 60.0
    static let RawAmountKey = "RawAmount"
    static let LastRefreshDateKey = "LastRefreshDate"
    static let DefaultTipPercentageKey = "DefaultTipPercentage"
    static let tipPercentages = [0.18, 0.20, 0.22]
    
    static func getRawAmount() -> String {
        let defaults = NSUserDefaults.standardUserDefaults()
        let prevRawAmount = defaults.objectForKey(RawAmountKey) as? String ?? ""
        let lastRefreshDate = defaults.objectForKey(LastRefreshDateKey) as! NSDate!
        if (lastRefreshDate == nil) {
            return ""
        }
        let diffSec = (NSDate().timeIntervalSinceReferenceDate - lastRefreshDate.timeIntervalSinceReferenceDate)
        if (diffSec > DefaultSecondsBeforeRefreshing) {
            saveRawAmount("")
            return ""
        } else {
            return prevRawAmount
        }
    }
    
    static func saveRawAmount(rawAmount: String) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(rawAmount, forKey: RawAmountKey)
        defaults.setObject(NSDate(), forKey: LastRefreshDateKey)
        defaults.synchronize()
    }
    
    static func getDefaultTipPercentage() -> Double? {
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.objectForKey(DefaultTipPercentageKey) as? Double
    }
    
    static func saveDefaultTipPercentage(tipPercentage: Double) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(tipPercentage, forKey: DefaultTipPercentageKey)
        defaults.synchronize()
    }
}
