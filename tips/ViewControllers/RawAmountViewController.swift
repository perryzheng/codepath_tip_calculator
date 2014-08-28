//
//  RawAmountViewController.swift
//  tips
//
//  Created by Perry Zheng on 8/27/14.
//  Copyright (c) 2014 Perry Zheng. All rights reserved.
//

import UIKit

class RawAmountViewController: UIViewController {

    @IBOutlet weak var rawAmountField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rawAmountField.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func enterRawAmount(sender: AnyObject) {
        if (!rawAmountField.text.isEmpty) {
            self.performSegueWithIdentifier("check_list_view", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "check_list_view") {
            println("preparing for segue")
            if (segue.destinationViewController .isKindOfClass(ViewController)) {
                let vc: ViewController  = segue.destinationViewController as ViewController
                var text = rawAmountField.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                text = text.substringFromIndex(text.startIndex.successor())
//                println("text=" + text)
//                let rawAmount = text.substringFromIndex(text.startIndex.successor())._bridgeToObjectiveC().doubleValue
//                println(rawAmount)
                vc.rawAmount = text
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
