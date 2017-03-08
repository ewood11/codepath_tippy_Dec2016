//
//  SettingsViewController.swift
//  tippy_December2016
//
//  Created by jpwood on 3/5/17.
//  Copyright © 2017 jpwood. All rights reserved.
//

import UIKit

class SettingsViewController:
          UIViewController,UIPickerViewDataSource, UIPickerViewDelegate
{
    
    @IBOutlet weak var picker1: UIPickerView!
    
     var picker_Data: [String] = [String]()
     var picker_percent: [String] = [String]()
    var tip_selected: String = " "
    
    @IBOutlet weak var picker_Sel_Label: UILabel!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        picker_Data =
            [ "10 Percent",
              "12.5 Precent",
              "15 Percent",
              "17.5 Percent",
              "20 Percent",
              "22.5 Percent",
              "25 Percent"   ]
        picker_percent =
            [ "10",
              "12.5",
              "15",
              "17.5",
              "20",
              "22.5",
              "25"   ]
        
       let userDefaults = Foundation.UserDefaults.standard
        
        picker_Sel_Label.text = userDefaults.string(forKey: "tipDefault")
        
    }
    
    @IBAction func default_Save_Label(_ sender: Any)
    {
        print("Default_Saved_Label:", tip_selected)
        let userDefaults = Foundation.UserDefaults.standard
        
        userDefaults.set(tip_selected, forKey: "tipDefault")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return picker_Data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return picker_Data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        picker_Sel_Label.text = picker_percent[row]
        tip_selected =
            picker_Sel_Label.text!
    }
  
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController)
    {
        print("SettingsVC unwind called:saved tip=", tip_selected)
    }
    
      
    override func canPerformUnwindSegueAction(_ action: Selector, from fromViewController: UIViewController, withSender sender: Any) -> Bool {
        print("SettingsVC canPerformUnwindSequeAction called:saved tip=", tip_selected)
        return true
    }
    
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
