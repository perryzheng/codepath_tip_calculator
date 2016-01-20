//
//  SettingsViewController.swift
//  tips
//
//  Created by Perry Zheng on 1/19/16.
//  Copyright © 2016 Perry Zheng. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaultTipPercentageOpt = Utils.getDefaultTipPercentage()
        if let defaultTipPercentage = defaultTipPercentageOpt {
            if let index = Utils.tipPercentages.indexOf(defaultTipPercentage) {
                tipControl.selectedSegmentIndex = index
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func indexChanged(sender: UISegmentedControl) {
        let defaultTipPercentage = Utils.tipPercentages[tipControl.selectedSegmentIndex]
        Utils.saveDefaultTipPercentage(defaultTipPercentage)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
