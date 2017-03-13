//
//  ViewController.swift
//  tippy_December2016
//
//  Created by ewood on 3/3/17.
//  Copyright © 2017 ewood. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    var Saved_Default_tip: String?
    let UD_billAmt:  String = "UD_bill_Amount"
    let UD_saveDate: String = "UD_save_Date"
    let UD_tipPCent: String = "UD_tip_PC_save"
    let locale_cur = Locale.current
//    let locale_symbol =  locale_cur.symbol
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var SavedTipDef_Label: UILabel!
    @IBAction func billResetButton(_ sender: Any)
    {
        let userDefaults = Foundation.UserDefaults.standard
        userDefaults.set("", forKey:UD_billAmt)
        billField.text = ""
        view.endEditing(false)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print ("VC_VDL01:currency_symbols=[", locale_cur, "]")
//        switch (locale_cur) {
//            case "en_UK": print("VC_VDL12: en_uk")
//            case "en_US": print("VC_VDL14: en_us"
//            default     : print("VC_VDL29: default")
//        }
//          self.onTap(billField)
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        let now = Foundation.Date()
        printLog(log: "M_viewWillAppear_10" as AnyObject)
        let userDefaults = Foundation.UserDefaults.standard
        var saveDate: Date! = nil
        
        let formatter: DateFormatter = DateFormatter.init()
        if (userDefaults.value(forKey:UD_saveDate) != nil)
        {
            saveDate = userDefaults.value(forKey: UD_saveDate) as! Date
            let expireTime: Date =
                saveDate.addingTimeInterval(600)
            let saveDateC = formatter.string(from: saveDate)
            let expireTimeC = formatter.string(from: expireTime)
            print("ViewWillAppear_20: Saved Date()=",  (saveDate), " now= ",  (now),
                  " ExpireTime= ",  (expireTime))
            
            let notExpire: Bool = expireTime > now
            if (notExpire) {
                  print("M_VWAppear_22 not expired")
             } else  {
                  print("M_VWAppear_24 yes expired")
                  userDefaults.set("", forKey:UD_billAmt)
                  billField.text = ""
            }
        }
        
        var billAmt: String = "";
        if (userDefaults.value(forKey: UD_billAmt) != nil)
        {
            billAmt = userDefaults.value(forKey:UD_billAmt) as! String
            print("ViewWillAppear_30 saved billAmt:", (billAmt) )
            billField.text = billAmt
        }
        
        let tip_from_Settings: String = ""
        SavedTipDef_Label.text = ""
        let formatter1 = DateFormatter.init()
        if (userDefaults.value(forKey: UD_tipPCent) != nil)
        {
           let tip_settings = userDefaults.value(forKey: UD_tipPCent)
            
//           print("M_WWA_Debug_035[",formatter1.string(from: tip_settings as! Date),"]")
           SavedTipDef_Label.text = tip_settings as! String?
//         SavedTipDef_Label.text = tip_from_Settings
        }
        
        switch (SavedTipDef_Label.text)
        {
        case "10"?:
            tipControl.selectedSegmentIndex = 0
        case "12.5"?:
            tipControl.selectedSegmentIndex = 1
        case "15"?:
            tipControl.selectedSegmentIndex = 2
        case "17.5"?:
            tipControl.selectedSegmentIndex = 3
        case "20"?:
            tipControl.selectedSegmentIndex = 4
        case "22.5"?:
            tipControl.selectedSegmentIndex = 5
        case "25"?:
            tipControl.selectedSegmentIndex = 6
        default: print (
            "Error in View_C Seg_Control_55[", SavedTipDef_Label.text as Any, "]")
        }
        
        var secsElapse: Int = 0
        if (saveDate != nil) {
            secsElapse = Int(now.timeIntervalSince(saveDate))
            print("SettingsCntlr VVA_60:", saveDate, now, secsElapse)
        }
        
        //        imageView1.animatew
        imageView1.startAnimating()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func seg_value_Changed(_ sender: Any) {
        
//        var local_currency: String = currency_symbols
        
        let tipPercentages =
            [ 0.1, 0.125, 0.15, 0.175,0.2, 0.225, 0.25 ]
        
        let bill = Double(billField.text!) ?? 0
        let  tip = bill * (tipPercentages[tipControl.selectedSegmentIndex]);
        let total = bill + tip
        
//        tipLabel.text = currency_symbol ?? ""
        tipLabel.text =  String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    @IBAction func save_tip_Amount(_ sender: Any)
    {
        let userDefaults = Foundation.UserDefaults.standard
        userDefaults.set(billField.text, forKey:UD_billAmt)
        let now: Date = Foundation.Date()
        userDefaults.set(now, forKey:UD_saveDate)
    }
    
    @IBAction func calculateTip(_ sender: Any)
    {
        let now: Date = Foundation.Date()
        let userDefaults = Foundation.UserDefaults.standard
        userDefaults.set(billField.text, forKey:"billAmount")
        userDefaults.set(now, forKey:UD_saveDate)
        
        let tipPercentages =
             [ 0.1, 0.125, 0.15, 0.175,0.2, 0.225, 0.25 ]

        let bill = Double(billField.text!) ?? 0
        let  tip = bill * (tipPercentages[tipControl.selectedSegmentIndex]);
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
  
    
    @IBAction func onTap(_ sender: Any)    {
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
    
//    func currencySymbol_wholeName(forLocale locale:
//        Locale = Locale.currentLocale()) -> String
//    {
//          var identifier : String = locale.localeIdentifier
//          switch(identifier) {
//          case "en_UK":
//              return "Pounds"
//          case "en_US":
//              return "Dollar"
//          default:
//              return ""
//          }
//    }
    
}

