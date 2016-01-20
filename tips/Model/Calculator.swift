//
//  CurrentAmount.swift
//  tips
//
//  Created by Perry Zheng on 8/29/14.
//  Copyright (c) 2014 Perry Zheng. All rights reserved.
//

import UIKit

class Calculator: NSObject {
    var _rawAmount: String = ""
    var _defaultTipPercentage: Double = 0.0
    
    // number of seconds before we refresh the last saved raw amount
    let DefaultSecondsBeforeRefreshing = 60.0
    let RawAmountKey = "RawAmount"
    let LastRefreshDateKey = "LastRefreshDate"
    let DefaultTipPercentageKey = "DefaultTipPercentage"
    
    func getRawAmount() -> String {
        let defaults = NSUserDefaults.standardUserDefaults()
        let prevRawAmount = defaults.objectForKey(RawAmountKey) as? String ?? ""
        let lastRefreshDate = defaults.objectForKey(LastRefreshDateKey) as! NSDate!
        if (lastRefreshDate == nil) {
            return ""
        }
        let diffSec = (NSDate().timeIntervalSinceReferenceDate - lastRefreshDate.timeIntervalSinceReferenceDate)
        if (diffSec > DefaultSecondsBeforeRefreshing) {
            self.setRawAmount("")
            return ""
        } else {
            return prevRawAmount
        }
    }
    
    func setRawAmount(rawAmount: String) {
        self._rawAmount = rawAmount
        synchronizeRawAmount()
    }
    
    func getDefaultTipPercentage() -> Double? {
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.objectForKey(DefaultTipPercentageKey) as? Double
    }
    
    func setDefaultTipPercentage(tipPercentage: Double) {
        self._defaultTipPercentage = tipPercentage
        synchronizeDefaultTipPercentage()
    }
    
    private func synchronizeRawAmount() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(_rawAmount, forKey: RawAmountKey)
        defaults.setObject(NSDate(), forKey: LastRefreshDateKey)
        defaults.synchronize()
    }
    
    private func synchronizeDefaultTipPercentage() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(_defaultTipPercentage, forKey: DefaultTipPercentageKey)
        defaults.synchronize()
    }
}
