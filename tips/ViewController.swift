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
    //@IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    let uiImage = UIImage(named:"person.png")
    let numPeople: Int = 10
    var items: [String] = ["hi", "foo", "bar"]
    private var total: Double = 0.0
    //@IBOutlet weak var totalAmountsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        billField.becomeFirstResponder()
        billField.text = rawAmount
        onEditingChanged(self)
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        checkSplitTableView.reloadData()
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("person split cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel.textAlignment = NSTextAlignment.Right
        cell.textLabel.textColor = UIColor.greenColor()

        var tipPercentages = [0.18, 0.20, 0.22]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        var billAmount = billField.text._bridgeToObjectiveC().doubleValue
        var tip = billAmount * tipPercentage
        total = billAmount + tip
        
        if (indexPath.row == 0)
        {
            cell.textLabel.text = String(format: "$%.2f", tip)
            cell.textLabel.font = UIFont(name:"HelveticaNeue-Light", size: 20.0)
        }
        else
        {
            for var i = 0; i < indexPath.row; i++
            {
                cell.contentView.addSubview(getPersonImageView(i))
            }
            cell.textLabel.text = String(format: "$%.2f", total / Double(indexPath.row + 1))
            cell.textLabel.font = UIFont(name:"HelveticaNeue-Light", size: 40.0)
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

