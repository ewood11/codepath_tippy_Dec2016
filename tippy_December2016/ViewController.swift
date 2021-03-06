//
//  ViewController.swift
//  tippy_December2016
//
//  Created by ewood on 3/3/17.
//  Copyright © 2017 ewood. All rights reserved.
//

import UIKit

class ViewController: UIViewController, passTipThemeDelegate
{
    let settingsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondVC") as! SettingsViewController
    
    let locale_identifiers = ["en_UK", "en_US", "es_US", "fr_FR", "it_IT", "zh_Hans_CN", "zh_Hans_HK"]
    
    var locale_dict: [String: Locale ] = ["en_UK": Locale.current, "en_US": Locale.current, "es_US": Locale.current, "fr_FR": Locale.current, "it_IT": Locale.current, "zh_Hans_CN": Locale.current, "zh_Hans_HK": Locale.current ]
    
    var symbols_dict: [String: String? ] = ["en_UK": Locale.current.currencySymbol, "en_US": Locale.current.currencySymbol, "es_US": Locale.current.currencySymbol,  "fr_FR": Locale.current.currencySymbol, "it_IT": Locale.current.currencySymbol, "zh_Hans_CN": Locale.current.currencySymbol, "zh_Hans_HK": Locale.current.currencySymbol ]
    
    var Saved_Default_tip: String?
    var app_locale:   Locale = Locale.current
//    var app_currency_symbol: String  =     
//          app_locale.object(forKey: "currencySymbol")
    let UD_billAmt:   String = "UD_bill_Amount"
    let UD_saveDate:  String = "UD_save_Date"
    let UD_tipPCent:  String = "UD_tip_PC_save"
    let UD_appLocale: String = "UD_Locale_save"
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var billField1: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var SavedTipDef_Label: UILabel!
    @IBOutlet weak var SavedLocale_Label: UILabel!
    
    var retn_theme2set_B: Bool = false
    
//    @IBAction func billResetButton(_ sender: Any)
//    {
//        let userDefaults = Foundation.UserDefaults.standard
//        userDefaults.set("", forKey:UD_billAmt)
//        billField1.text = ""
//        view.endEditing(false)
//    }
    
    
    @IBAction func ToSettings(_ sender: UIButton) {

        self.present(settingsVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        settingsVC.tipThemeDelegate = self
        
        for (_, e) in (locale_identifiers.enumerated()) {
            let locale: Locale = Locale.init(identifier: e)
           locale_dict[e] = locale
           let currencySymbol = locale.currencySymbol
           symbols_dict[e] = currencySymbol
           print ("VC_VDL01:locale=[", e, "] currency_symbol=", currencySymbol as Any)

        }
        
        let bf_fr: Bool = billField1.becomeFirstResponder(
        )
        if (bf_fr) {
            print("mainVC22: BF 1 resp ok")
        } else {
            print("mainVC24: BF 1 resp nogo")
        }
        
//      self.onTap(billField)
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
            print("ViewWillAppear_20: Saved Date()=",  (saveDate), " now= ",  (now), " ExpireTime= ",  (expireTime))
            
            let notExpire: Bool = expireTime > now
            if (notExpire) {
                  print("M_VWAppear_22 not expired")
             } else  {
                  print("M_VWAppear_24 yes expired")
                  userDefaults.set("", forKey:UD_billAmt)
                  billField1.text = ""
            }
        }
        
        SavedLocale_Label.text = ""
        if (userDefaults.value(forKey: UD_appLocale) != nil)
        {
            let saved_locale: String = userDefaults.value(forKey: UD_appLocale) as! String
            for locale_str in locale_identifiers
            {
                if (saved_locale == locale_str) {
                    app_locale = locale_dict[locale_str]!
                    SavedLocale_Label.text = saved_locale
                }
            }
            print("VC1_WWA_050 App_saved_Locale_str=[", saved_locale)
        } else {
            print("VC1_WWA_051 No saved Locale found")
        }
        
        var billAmt: String = "";
        if (userDefaults.value(forKey: UD_billAmt) != nil)
        {
            billAmt = userDefaults.value(forKey:UD_billAmt) as! String
            print("ViewWillAppear_60 saved billAmt:", (billAmt) )
            billField1.text = billAmt
        }
        
//      let tip_from_Settings: String = ""
        SavedTipDef_Label.text = ""
        let tip_Formatter: NumberFormatter = NumberFormatter()
        tip_Formatter.usesGroupingSeparator = true
        tip_Formatter.numberStyle = .currency
        tip_Formatter.locale = app_locale
        
        if (userDefaults.value(forKey: UD_tipPCent) != nil)
        {
           let tip_settings: String = userDefaults.value(forKey: UD_tipPCent) as! String
            let tipFromStr1:NSNumber = Double(tip_settings) as NSNumber? ?? 0.0
            let temp1:String = tip_Formatter.string(from: tipFromStr1 as NSNumber)!
            print("M_WWA_Debug065 [", temp1, "]")
            SavedTipDef_Label.text = tip_settings
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
            "Error in View_C Seg_Control_75[", SavedTipDef_Label.text as Any, "]")
        }
        
        var secsElapse: Int = 0
        if (saveDate != nil) {
            secsElapse = Int(now.timeIntervalSince(saveDate))
            print("SettingsCntlr VVA_60:", saveDate, now, secsElapse)
        }
        
//        let bf_fr: Bool = billField1.becomeFirstResponder(
//        )
//        if (bf_fr) {
//            print("mainVC26: BF 1 resp ok")
//        } else {
//            print("mainVC28: BF 1 resp nogo")
//        }
        
        if (retn_theme2set_B)
        {
          self.view.backgroundColor = UIColor.lightGray
          billField1.backgroundColor = UIColor.lightGray
          billField1.textColor = UIColor.yellow
          tipLabel.backgroundColor = UIColor.lightGray
          tipLabel.textColor = UIColor.yellow
          totalLabel.backgroundColor = UIColor.lightGray
          totalLabel.textColor = UIColor.yellow
          tipControl.backgroundColor = UIColor.lightGray
        
          SavedTipDef_Label.backgroundColor = UIColor.lightGray
          SavedTipDef_Label.textColor = UIColor.yellow
          SavedLocale_Label.backgroundColor = UIColor.lightGray
          SavedLocale_Label.textColor = UIColor.yellow
        } else {
            self.view.backgroundColor = UIColor.white
            billField1.backgroundColor = UIColor.white
            billField1.textColor = UIColor.black
            tipLabel.backgroundColor = UIColor.white
            tipLabel.textColor = UIColor.black
            totalLabel.backgroundColor = UIColor.white
            totalLabel.textColor = UIColor.black
            tipControl.backgroundColor = UIColor.white
            
            SavedTipDef_Label.backgroundColor = UIColor.white
            SavedTipDef_Label.textColor = UIColor.black
            SavedLocale_Label.backgroundColor = UIColor.white
            SavedLocale_Label.textColor = UIColor.black
        }
        
        
        //        imageView1.animatew
        imageView1.startAnimating()
        
    }
    
//    @IBAction func SettingsButtonPressed(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
//        localeDataDelegate?.passlocateData(locale: locale_identifiers)
//    }
    
    @IBAction func seg_value_Changed(_ sender: Any) {
        
        let tipPercentages =
            [ 0.1, 0.125, 0.15, 0.175,0.2, 0.225, 0.25 ]
        
        let bill = Double(billField1.text!) ?? 0
        let  tip = bill * (tipPercentages[tipControl.selectedSegmentIndex]);
        let total = bill + tip
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle =
            .currency
        
        currencyFormatter.locale = app_locale
      
        var tipStr:String = ""
        let tip_fmt_D: NSNumber = Double(tip) as NSNumber? ?? 0.0
        tipStr = currencyFormatter.string(from: tip_fmt_D as NSNumber)!
        tipLabel.text = tipStr
//            String(format: "$%.2f", tipStr)
        
        var totalStr:String = ""
        let tot_fmt_D: NSNumber = Double(total) as NSNumber? ?? 0.0
        totalStr = currencyFormatter.string(from: tot_fmt_D as NSNumber)!
        totalLabel.text = totalStr
//          String(format: "$%.2f", totalStr)
        print("VC_SVC_90 tipstr", tipStr, " totalStr=", totalStr)
    }
    
    @IBAction func save_tip_Amount(_ sender: Any)
    {
        let userDefaults = Foundation.UserDefaults.standard
        userDefaults.set(billField1.text, forKey:UD_billAmt)
        let now: Date = Foundation.Date()
        userDefaults.set(now, forKey:UD_saveDate)
    }
    
    @IBAction func calculateTip(_ sender: Any)
    {
        let now: Date = Foundation.Date()
        let userDefaults = Foundation.UserDefaults.standard
        userDefaults.set(billField1.text, forKey:"billAmount")
        userDefaults.set(now, forKey:UD_saveDate)
        
        let tipPercentages =
             [ 0.1, 0.125, 0.15, 0.175,0.2, 0.225, 0.25 ]

        let bill = Double(billField1.text!) ?? 0
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
    
    func passTipTheme(lightDark: Bool) {
        retn_theme2set_B = lightDark
        print("VC2=>VC1_return_TipTheme=[", retn_theme2set_B, "]")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// protocol passLocaleDataDelegate {
//    func passlocateData(locale: [String])
// }

