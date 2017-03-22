//
//  SettingsViewController.swift
//  tippy_December2016
//
//  Created by ewood on 3/5/17.
//  Copyright © 2017 ewood. All rights reserved.
//

import UIKit

class SettingsViewController:
          UIViewController,UIPickerViewDataSource,UIPickerViewDelegate
{
    let THEME_DARK  = "Calculator Theme: Dark"
    let THEME_LIGHT = "Calculator Theme: Light"
    var tipThemeDelegate: passTipThemeDelegate?
    var themes2set_B: Bool = false
    
    @IBOutlet weak var LD_Theme_switch: UISwitch!
    
    @IBAction func ToTipCal(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
        tipThemeDelegate?.passTipTheme(lightDark: themes2set_B)
    }
    
    @IBOutlet weak var theme_switch_label: UILabel!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var picker1: UIPickerView!
     var picker_percent: [String] = [String]()
     var tip_selected   : String = " "
     var locale_selected: String = ""
    
    var picker_Data: [String] =
     [ "10 Percent",
       "12.5 Precent",
       "15 Percent",
       "17.5 Percent",
       "20 Percent",
       "22.5 Percent",
       "25 Percent"   ]
    
    @IBOutlet weak var picker_Sel_Label: UILabel!
    let UD_tipPCent  : String = "UD_tip_PC_save"
    let UD_app_locale: String = "UD_Locale_save"
    
//  @IBOutlet weak var picker2: UIPickerView!
    @IBOutlet weak var locale_Sel_Label: UILabel!
    
    @IBOutlet weak var Tip_Hdr_Label: UILabel!
    @IBOutlet weak var Locale_Hdr_Label: UILabel!
    
    var  picker2_data: [String] = ["en_UK", "en_US", "es_US", "fr_FR", "it_IT", "zh_Hans_CN", "zh_Hans_HK"]

    @IBAction func LD_ThemeSwitchPressed(_ sender: UISwitch)
    {
        if (sender.isOn) {
           themes2set_B = true
           theme_switch_label.text = THEME_DARK
           settings_Theme_dark()
        } else {
           themes2set_B = false
           theme_switch_label.text = THEME_LIGHT
           settings_Theme_light()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        picker_percent =
            [ "10",
              "12.5",
              "15",
              "17.5",
              "20",
              "22.5",
              "25"   ]
        
        if (themes2set_B) {
           theme_switch_label.text = THEME_DARK
        } else {
           theme_switch_label.text = THEME_LIGHT
        }
        
        let userDefaults = Foundation.UserDefaults.standard
        picker_Sel_Label.text = ""
        if (userDefaults.value(forKey: UD_tipPCent) != nil)
        {
            let savedTPC = userDefaults.value(forKey: UD_tipPCent)
            print("SVC_Debug_015 [", savedTPC as Any, "]")
            if (savedTPC is Date) { } else
            {
              picker_Sel_Label.text = savedTPC as! String?
            }
        }
        
        locale_Sel_Label.text = ""
        if (userDefaults.value(forKey: UD_app_locale) != nil)
        {
            let savedLoc = userDefaults.value(forKey: UD_app_locale)
            print("SVC_Debug_025 [", savedLoc as Any, "]")
            if (savedLoc is Date) { } else
            {
                locale_Sel_Label.text = savedLoc as! String?
            }
        }
    }
    
    func settings_Theme_dark() {
        self.view.backgroundColor = UIColor.lightGray
        
        picker1.backgroundColor = UIColor.lightGray
        Tip_Hdr_Label.textColor =
            UIColor.init(red: 255.0, green: 0.0, blue: 230.0, alpha: 1)
        Locale_Hdr_Label.textColor =
            UIColor.init(red: 255.0, green: 0.0, blue: 230.0, alpha: 1)
        picker_Sel_Label.textColor =
            UIColor.init(red: 255.0, green: 0.0, blue: 230.0, alpha: 1)
        locale_Sel_Label.textColor =
            UIColor.init(red: 255.0, green: 0.0, blue: 230.0,  alpha: 1)
    }
    func settings_Theme_light() {
        self.view.backgroundColor = UIColor.white
        picker1.backgroundColor = self.view.backgroundColor
        Tip_Hdr_Label.textColor    = UIColor.black
        Locale_Hdr_Label.textColor = UIColor.black
        picker_Sel_Label.textColor = UIColor.black
        locale_Sel_Label.textColor = UIColor.black
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if (themes2set_B) {
           settings_Theme_dark()
        } else {
           settings_Theme_light()
        }
    }
    
    @IBAction func default_Save_Label(_ sender: Any)
    {
        print(" SettingsVC: 015 Tip_Sel:", tip_selected, " Locale_Sel:", locale_selected)
        let userDefaults = Foundation.UserDefaults.standard
        userDefaults.set(tip_selected, forKey: UD_tipPCent)
        userDefaults.set(locale_selected, forKey: UD_app_locale)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1) {
            return picker_Data.count
        } else  if (pickerView.tag == 2){
            return picker2_data.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (component == 0) {
            return picker_Data[row]
        } else if (component == 1) {
            return picker2_data[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let userDefaults = Foundation.UserDefaults.standard
        if (component == 0) {
           picker_Sel_Label.text = picker_percent[row]
           tip_selected = picker_Sel_Label.text!
           userDefaults.set(picker_percent[row],
              forKey: UD_tipPCent )
        }  else if (component == 1) {
            locale_Sel_Label.text = picker2_data[row]
            locale_selected = locale_Sel_Label.text!
            userDefaults.set(picker2_data[row],
              forKey: UD_app_locale )
        }
    
    }
  
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController)
    {
        print("SettingsVC unwind called:saved tip=", tip_selected)
    }
      
    override func canPerformUnwindSegueAction(_ action: Selector, from fromViewController: UIViewController, withSender sender: Any) -> Bool {
        print("SettingsVC canPerformUnwindSequeAction called:saved tip=", tip_selected)
        return true
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        if (pickerView.tag == 1) {
        if (component == 0) {
    	    let titleData1 = picker_Data[row]
    	    let myTitle1 = NSAttributedString(string: titleData1, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 22.0)!,NSForegroundColorAttributeName:UIColor.blue])
    	    return myTitle1
        } else if (component == 1) {
            let titleData2 = picker2_data[row]
            let myTitle2 = NSAttributedString(string: titleData2, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 22.0)!,NSForegroundColorAttributeName:UIColor.blue])
            return myTitle2
        }
        return NSAttributedString(
         string: "", attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 22.0)!,NSForegroundColorAttributeName:UIColor.blue])
    }
    
    	/* better memory management version */
    	    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
            {
    	        var pickerLabel = view as! UILabel!
                if (component == 0)
                {
                   let pickerLabel1 = UILabel()
    	           if view == nil {  //if no label there yet
    	               //color the label's background
                       let hue = CGFloat(row) / CGFloat(picker_Data.count)
    	               pickerLabel1.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
    	            }
    	            let titleData = picker_Data[row]
    	            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 22.0)!,NSForegroundColorAttributeName:UIColor.black])
    	            pickerLabel1.attributedText = myTitle
    	            pickerLabel1.textAlignment = .center
                    pickerLabel = pickerLabel1
                } else if (component == 1) {
                    let pickerLabel2 = UILabel()
                    if view == nil {  //if no label there yet
                        //color the label's background
                        let hue = CGFloat(row) / CGFloat(picker2_data.count)
                        pickerLabel2.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
                    }
                    let titleData = picker2_data[row]
                    let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 22.0)!,NSForegroundColorAttributeName:UIColor.black])
                    pickerLabel2.attributedText = myTitle
                    pickerLabel2.textAlignment = .center
                    pickerLabel = pickerLabel2
                }
    	        return pickerLabel!
    	    }
    
    	    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    	        return 40.0
    	    }

    	    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
    	        return 145
    	    }

    func passSettingsTheme(lightDark: Bool)
    {
       
        themes2set_B = lightDark
        print("VC3_=>_VC2_passSettingsThemeData=[", lightDark, "]" )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
// Dispose of any resources that can be recreated.
    }
    
  }

protocol passTipThemeDelegate {
    func passTipTheme(lightDark: Bool)
}
