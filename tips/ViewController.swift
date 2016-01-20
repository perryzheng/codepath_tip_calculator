//
//  ViewController.swift
//  tips
//
//  Created by Perry Zheng on 8/26/14.
//  Copyright (c) 2014 Perry Zheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
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
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"appEnterForeground:", name:
            UIApplicationWillEnterForegroundNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"appResign:", name: UIApplicationWillResignActiveNotification, object: nil)

    }
    
    func updateUI() {
        rawAmount = billField.text!
        if let symbol = NSLocale.currentLocale().objectForKey(NSLocaleCurrencySymbol) {
            billField.attributedPlaceholder = NSAttributedString(string: "\(symbol)")
        }

        if (rawAmount == "") {
            checkSplitTableView.hidden = true
            tipControl.hidden = true
            billField.frame = CGRectMake(billField.frame.origin.x, rawViewBillFieldYPosition, billField.frame.size.width, billField.frame.size.height)
        } else {
            billField.frame = CGRectMake(billField.frame.origin.x, populatedBillFieldYPosition, billField.frame.size.width, billField.frame.size.height)
            checkSplitTableView.hidden = false
            tipControl.hidden = false
        }
        billField.becomeFirstResponder()
        checkSplitTableView.reloadData()
    }
    
    func appEnterForeground(notification: NSNotification) {
        rawAmount = Utils.getRawAmount()
        billField.text = rawAmount
        onEditingChanged(self)
    }
  
    func appResign(notification: NSNotification) {
        Utils.saveRawAmount(rawAmount)
    }
    
    override func viewWillAppear(animated: Bool) {
        let defaultTipPercentageOpt = Utils.getDefaultTipPercentage()
        if let defaultTipPercentage = defaultTipPercentageOpt {
            let index = Utils.tipPercentages.indexOf(defaultTipPercentage)
            tipControl.selectedSegmentIndex = index!
        }
        updateUI()
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
        Utils.saveRawAmount(rawAmount)
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        saveRawAccount()
        
        let cell = tableView.dequeueReusableCellWithIdentifier("person split cell", forIndexPath: indexPath)
        cell.textLabel!.textAlignment = NSTextAlignment.Right
        cell.textLabel!.textColor = UIColor.greenColor()

        let tipPercentage = Utils.tipPercentages[tipControl.selectedSegmentIndex]
        
        let billAmount = billField.text!._bridgeToObjectiveC().doubleValue
        let tip = billAmount * tipPercentage
        total = billAmount + tip
        
        let symbol = NSLocale.currentLocale().objectForKey(NSLocaleCurrencySymbol) as? String ?? "$"
        if (indexPath.row == 0) {
            for view in cell.contentView.subviews {
                view.removeFromSuperview()
            }
            
            cell.textLabel!.text = String(format: "Tip: \(symbol)%.2f", tip)
            cell.textLabel!.font = UIFont(name:"HelveticaNeue-Thin", size: 20.0)
        } else {
            for var i = 0; i < indexPath.row; i++ {
                var imv = getPersonImageView(i)
                cell.contentView.addSubview(imv)
                imv = nil
            }
            cell.textLabel!.text = String(format: "\(symbol)%.2f", total / Double(indexPath.row))
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

