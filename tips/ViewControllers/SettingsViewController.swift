//
//  SettingsViewController.swift
//  tips
//
//  Created by Perry Zheng on 1/18/16.
//  Copyright © 2016 Perry Zheng. All rights reserved.
//

import UIKit

protocol SettingsControllerDelegate: class {
    func settingsController(settingVC: SettingsViewController, didSaveTipPercentage percentage: Double)
}

class SettingsViewController: UIViewController {

    weak var delegate: SettingsControllerDelegate?
    var tipPercentage: Double?
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
