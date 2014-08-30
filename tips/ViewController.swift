//
//  ViewController.swift
//  tips
//
//  Created by Perry Zheng on 8/26/14.
//  Copyright (c) 2014 Perry Zheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tipsNSUserDefaults: TipsNSUserDefaults = TipsNSUserDefaults()
    
    var rawAmount: String = ""
    
    @IBOutlet weak var checkSplitTableView: UITableView!;
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    let uiImage = UIImage(named:"person.png")
    let numPeople: Int = 8

    private var total: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("in view controller")
        updateUI()
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"appDidBecomeActive:", name: UIApplicationDidBecomeActiveNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"appResign:", name: UIApplicationWillResignActiveNotification, object: nil)

    }
    
    func updateUI() {
        billField.becomeFirstResponder()
        rawAmount = tipsNSUserDefaults.getRawAmount()
        billField.text = rawAmount
        onEditingChanged(self)
    }
    
    func appDidBecomeActive(notification: NSNotification) {
        println("in ViewController didBecomeActive")
        rawAmount = tipsNSUserDefaults.getRawAmount()
        println("in ViewController=" + rawAmount)
        updateUI()
    }
    
    func appResign(notification: NSNotification) {
        println("in ViewController appResign")
        println(rawAmount)
        tipsNSUserDefaults.setRawAmount(rawAmount)
    }
    
    override func viewWillDisappear(animated: Bool) {
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        tipsNSUserDefaults.setRawAmount(rawAmount)
        checkSplitTableView.reloadData()
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        if (billField.text.isEmpty) {
            tipsNSUserDefaults.setRawAmount("")
            self.performSegueWithIdentifier("to raw amount segue", sender: self)
        }
        
        var cell = tableView.dequeueReusableCellWithIdentifier("person split cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel.textAlignment = NSTextAlignment.Right
        cell.textLabel.textColor = UIColor.greenColor()

        var tipPercentages = [0.18, 0.20, 0.22]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        var billAmount = billField.text._bridgeToObjectiveC().doubleValue
        rawAmount = billField.text
        var tip = billAmount * tipPercentage
        total = billAmount + tip
        
        if (indexPath.row == 0) {
            for view in cell.contentView.subviews {
                view.removeFromSuperview()
            }
            
            cell.textLabel.text = String(format: "Tip: $%.2f", tip)
            cell.textLabel.font = UIFont(name:"HelveticaNeue-Thin", size: 20.0)
        } else {
            for var i = 0; i < indexPath.row; i++ {
                var imv = getPersonImageView(i)
                cell.contentView.addSubview(imv)
                imv = nil
            }
            cell.textLabel.text = String(format: "$%.2f", total / Double(indexPath.row))
            cell.textLabel.font = UIFont(name:"HelveticaNeue-Thin", size: 40.0)
        }
        return cell
    }
    
    func getPersonImageView(personI: Int) -> UIImageView! {
        let x: Double = Double(personI) * 20.0
        var imv = UIImageView(frame: CGRectMake(CGFloat(x), 7.8, 40, 40));
        imv.image = uiImage
        return imv
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return numPeople+1
    }
}

