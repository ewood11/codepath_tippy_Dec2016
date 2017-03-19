//
//  ThemesController.swift
//  tippy_December2016
//
//  Created by ewood on 3/17/17.
//  Copyright © 2017 ewood. All rights reserved.
//

import UIKit

class ThemesController: UIViewController {
    
    var delegate: passSettingsThemeDelegate?
    
    var theme_switch_B: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (theme_switch_B) {
            SettingsThemeVLabel.text = "Switch is On"        }
        else {
SettingsThemeVLabel.text = "Switch is Off"
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func GoToSettingsButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        delegate?.passSettingsTheme(lightDark: theme_switch_B)
    }

    
    @IBOutlet weak var SettingsThemeVLabel: UILabel!
    
        
    @IBAction func SettingsThemeSwitch(_ sender: UISwitch) 
    {
        if sender.isOn {
            theme_switch_B = true
            SettingsThemeVLabel.text = "Switch is On"
        } else {
            theme_switch_B = false
            SettingsThemeVLabel.text = "Switch is Off"
        }
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

protocol passSettingsThemeDelegate {
    func passSettingsTheme(lightDark: Bool)
}
