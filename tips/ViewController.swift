//
//  ViewController.swift
//  tips
//
//  Created by Perry Zheng on 8/26/14.
//  Copyright (c) 2014 Perry Zheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let bill: Bill = Bill()
    
    var rawAmount: String = ""
    
    @IBOutlet weak var checkSplitTableView: UITableView!;
    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    let uiImage = UIImage(named:"person.png")
    let numPeople: Int = 9
    let rawViewBillFieldYPosition = CGFloat(182.0)
    let populatedBillFieldYPosition = CGFloat(82.0)
    
    private var total: Double = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        //two are unnecessary and are here only for educational purposes
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"appBecomeActive:", name:
            UIApplicationDidBecomeActiveNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"appEnterForeground:", name:
            UIApplicationWillEnterForegroundNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"appEnterBackground:", name:
            UIApplicationDidEnterBackgroundNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"appResign:", name: UIApplicationWillResignActiveNotification, object: nil)

    }
    
    func updateUI() {
        rawAmount = billField.text!
        if (rawAmount == "") {
            checkSplitTableView.hidden = true
            tipControl.hidden = true
            billField.frame = CGRectMake(billField.frame.origin.x, rawViewBillFieldYPosition, billField.frame.size.width, billField.frame.size.height)
        } else {
            billField.frame = CGRectMake(billField.frame.origin.x, populatedBillFieldYPosition, billField.frame.size.width, billField.frame.size.height)
            checkSplitTableView.hidden = false
            tipControl.hidden = false
        }
        checkSplitTableView.reloadData()
        billField.becomeFirstResponder()
    }
    
    //ordering when exiting the app
    //appResign
    //appEnterBackground
    
    //ordengi when reopening the app
    //enterForeGround
    //appBecomeActive
    
    func appBecomeActive(notification: NSNotification) {
        print("in appBecomeActive")
    }
    
    func appEnterForeground(notification: NSNotification) {
        print("in ViewController enter foreground")
        rawAmount = bill.getRawAmount()
        onEditingChanged(self)
    }
    
    func appEnterBackground(notification: NSNotification) {
        print("in appEnterBackground")
    }
    
    func appResign(notification: NSNotification) {
        print("in ViewController appResign")
        bill.setRawAmount(rawAmount)
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
        updateUI()
    }
    
    private func saveRawAccount() {
        rawAmount = billField.text!
        bill.setRawAmount(rawAmount)
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        saveRawAccount()
        
        let cell = tableView.dequeueReusableCellWithIdentifier("person split cell", forIndexPath: indexPath)
        cell.textLabel!.textAlignment = NSTextAlignment.Right
        cell.textLabel!.textColor = UIColor.greenColor()

        var tipPercentages = [0.18, 0.20, 0.22]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        let billAmount = billField.text!._bridgeToObjectiveC().doubleValue
        let tip = billAmount * tipPercentage
        total = billAmount + tip
        
        if (indexPath.row == 0) {
            for view in cell.contentView.subviews {
                view.removeFromSuperview()
            }
            
            cell.textLabel!.text = String(format: "Tip: $%.2f", tip)
            cell.textLabel!.font = UIFont(name:"HelveticaNeue-Thin", size: 20.0)
        } else {
            for var i = 0; i < indexPath.row; i++ {
                var imv = getPersonImageView(i)
                cell.contentView.addSubview(imv)
                imv = nil
            }
            cell.textLabel!.text = String(format: "$%.2f", total / Double(indexPath.row))
            cell.textLabel!.font = UIFont(name:"HelveticaNeue-Thin", size: 40.0)
        }
        return cell
    }
    
    func getPersonImageView(personI: Int) -> UIImageView! {
        let x: Double = Double(personI) * 20.0
        let imv = UIImageView(frame: CGRectMake(CGFloat(x), 7.8, 40, 40));
        imv.image = uiImage
        return imv
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numPeople+1
    }
}

