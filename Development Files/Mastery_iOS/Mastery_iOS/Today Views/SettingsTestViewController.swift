//
//  SettingsTestViewController.swift
//  Mastery_iOS
//
//  Created by Cameron Mcleod on 2019-07-27.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class SettingsTestViewController: UIViewController {

    @IBOutlet weak var focusTimePicker: UIDatePicker!
    @IBOutlet weak var breakTimePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        focusTimePicker.countDownDuration = TimeInterval(UserDefaults.standard.integer(forKey: "focusTime"))
        breakTimePicker.countDownDuration = TimeInterval(UserDefaults.standard.integer(forKey: "breakTime"))
    }
    

    @IBAction func focusTimeChanged(_ sender: UIDatePicker) {
        
        let duration = Int(sender.countDownDuration)
        if duration == 0 {
            sender.countDownDuration = TimeInterval.init(60)
            UserDefaults.standard.set(duration, forKey: "focusTime")
        } else {
    
        UserDefaults.standard.set(duration, forKey: "focusTime")
        }
    }
    

    @IBAction func breakTimeChanged(_ sender: UIDatePicker) {
        
        let duration = Int(sender.countDownDuration)
        if duration == 0 {
            sender.countDownDuration = TimeInterval.init(60)
            UserDefaults.standard.set(duration, forKey: "breakTime")
        } else {
            
            UserDefaults.standard.set(duration, forKey: "breakTime")
        }
    }
    
   
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
