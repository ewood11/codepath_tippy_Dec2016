//
//  SettingsViewController.swift
//  tippy_December2016
//
//  Created by ewood on 3/5/17.
//  Copyright © 2017 ewood. All rights reserved.
//

import UIKit

class SettingsViewController:
          UIViewController,UIPickerViewDataSource, UIPickerViewDelegate
//    , passLocaleDataDelegate
{
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
    
    @IBOutlet weak var picker2: UIPickerView!
    @IBOutlet weak var locale_Sel_Label: UILabel!
    
    var  picker2_data: [String] = ["en_UK", "en_US", "es_US", "fr_FR", "it_IT", "zh_Hans_CN", "zh_Hans_HK"]

 //   let firstVC = UIStoryboard(name: "Tip Calculator",
 //   bundle:nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
//      firstVC.delegate = self
        picker_percent =
            [ "10",
              "12.5",
              "15",
              "17.5",
              "20",
              "22.5",
              "25"   ]
        
        let userDefaults = Foundation.UserDefaults.standard
        picker_Sel_Label.text = ""
        if (userDefaults.value(forKey: UD_tipPCent) != nil)
        {
//          let formatter2 = DateFormatter.init()
//          print("SVC_Debug M_020 [",
//               formatter2.string(from: 
//          userDefaults.value(forKey: UD_tipPCent)
//          as! Date), "]")
            
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//      self.view.backgroundColor = UIColor.cyan
//      self.view.backgroundColor = UIColor.lightGray
//      picker1.backgroundColor = UIColor.white
//  picker_Sel_Label.backgroundColor = UIColor.white
    }
    
    @IBAction func default_Save_Label(_ sender: Any)
    {
        print(" SettingsVC: 015 Tip_Sel:", tip_selected, " Locale_Sel:", locale_selected)
        let userDefaults = Foundation.UserDefaults.standard
        userDefaults.set(tip_selected, forKey: UD_tipPCent)
        userDefaults.set(locale_selected, forKey: UD_app_locale)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1) {
            return picker_Data.count
        } else {
            return picker2_data.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1) {
            return picker_Data[row]
        } else {
            return picker2_data[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let userDefaults = Foundation.UserDefaults.standard
        if (pickerView.tag == 1) {
           picker_Sel_Label.text = picker_percent[row]
           tip_selected = picker_Sel_Label.text!
           userDefaults.set(picker_percent[row],
              forKey: UD_tipPCent )
        }  else {
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
        if (pickerView.tag == 1) {
    	    let titleData1 = picker_Data[row]
    	    let myTitle1 = NSAttributedString(string: titleData1, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blue])
    	    return myTitle1
        } else {
            let titleData2 = picker2_data[row]
            let myTitle2 = NSAttributedString(string: titleData2, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blue])
            return myTitle2
        }
    }
    
    	/* better memory management version */
    	    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
            {
    	        var pickerLabel = view as! UILabel!
                if (pickerView.tag == 1)
                {
                   let pickerLabel1 = UILabel()
    	           if view == nil {  //if no label there yet
    	            
    	               //color the label's background
                       let hue = CGFloat(row) / CGFloat(picker_Data.count)
    	               pickerLabel1.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
    	            }
    	            let titleData = picker_Data[row]
    	            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 26.0)!,NSForegroundColorAttributeName:UIColor.black])
    	            pickerLabel1.attributedText = myTitle
    	            pickerLabel1.textAlignment = .center
                    pickerLabel = pickerLabel1
                } else {
                    let pickerLabel2 = UILabel()
                    if view == nil {  //if no label there yet
                        //color the label's background
                        let hue = CGFloat(row) / CGFloat(picker2_data.count)
                        pickerLabel2.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
                    }
                    let titleData = picker2_data[row]
                    let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 26.0)!,NSForegroundColorAttributeName:UIColor.black])
                    pickerLabel2.attributedText = myTitle
                    pickerLabel2.textAlignment = .center
                    pickerLabel = pickerLabel2
                }
    	        return pickerLabel!
    	    }
    
    	    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    	        return 36.0
    	    }
    	    // for best use with multitasking , dont use a constant here.
    	    //this is for demonstration purposes only.
    	    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
    	        return 200
    	    }

//    func passlocateData(locale: [String])
//    {
//    print("VC1_=>_VC2_passLocateData=[", locale, "]" )
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
// Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
