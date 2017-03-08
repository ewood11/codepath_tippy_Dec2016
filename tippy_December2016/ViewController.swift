//
//  ViewController.swift
//  tippy_December2016
//
//  Created by jpwood on 3/3/17.
//  Copyright © 2017 jpwood. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var Saved_Default_tip: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefaults = Foundation.UserDefaults.standard
        SavedTipDef_Label.text =      userDefaults.string(forKey: "tipDefault")
        print ("ViewController_DidLoad")
        print (SavedTipDef_Label.text)
      
        switch (SavedTipDef_Label.text)
        {
        case "10"?:
            tipControl.setEnabled(true, forSegmentAt: 0)
        case "12.5"?:
            tipControl.setEnabled(true, forSegmentAt: 1)
        case "15"?:
            tipControl.setEnabled(true, forSegmentAt: 2)
        case "17.5"?:
            tipControl.setEnabled(true, forSegmentAt: 3)
        case "20"?:
            tipControl.setEnabled(true, forSegmentAt: 4)
        case "22.5"?:
            tipControl.setEnabled(true, forSegmentAt: 5)
        case "25"?:
            tipControl.setEnabled(true, forSegmentAt: 6)
        default: print ("Error in ViewController Segmented Control locEyeCatch:1010")
        }
        printLog(log: "From main viewDidLoad" as AnyObject?)
    }

    override func viewWillAppear(_ animated: Bool)
    {
        printLog(log: "From main viewWillAppear" as AnyObject)
        
          let userDefaults = Foundation.UserDefaults
          var tip_from_Settings = userDefaults.standard.value(forKey: "tipDefault")
                
          printLog(log: tip_from_Settings as AnyObject)
          SavedTipDef_Label.text = tip_from_Settings as! String?
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var tipControl: UISegmentedControl!

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var SavedTipDef_Label: UILabel!
    
    @IBAction func seg_value_Changed(_ sender: Any) {
        let tipPercentages =
            [ 0.1, 0.125, 0.15, 0.175,0.2, 0.225, 0.25 ]
        
        let bill = Double(billField.text!) ?? 0
        let  tip = bill * (tipPercentages[tipControl.selectedSegmentIndex]);
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        let tipPercentages =
             [ 0.1, 0.125, 0.15, 0.175,0.2, 0.225, 0.25 ]

        let bill = Double(billField.text!) ?? 0
        let  tip = bill * (tipPercentages[tipControl.selectedSegmentIndex]);
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
    }
    @IBAction func onTap(_ sender: Any) {
         view.endEditing(true)
    }
    
    func printLog(log: AnyObject?) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        print(formatter.string(from: NSDate() as Date))
        if log == nil
        { print("nil") } else
        { print(log!)   }
    }
    
}

