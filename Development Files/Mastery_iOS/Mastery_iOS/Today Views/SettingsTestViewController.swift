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
        }
    }
    

    @IBAction func breakTimeChanged(_ sender: UIDatePicker) {
        
        let duration = Int(sender.countDownDuration)
        if duration == 0 {
            sender.countDownDuration = TimeInterval.init(60)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let focusTime = Int(focusTimePicker.countDownDuration)
        let breakTime = Int(breakTimePicker.countDownDuration)
        UserDefaults.standard.set(breakTime, forKey: "breakTime")
        UserDefaults.standard.set(focusTime, forKey: "focusTime")
        
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
