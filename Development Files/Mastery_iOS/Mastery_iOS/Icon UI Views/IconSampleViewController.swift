//
//  IconSampleViewController.swift
//  Mastery_iOS
//
//  Created by Cameron Mcleod on 2019-08-07.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class IconSampleViewController: UIViewController {
    
    var fillInTimer = Timer()
    var fillInCompletion : CGFloat = 0
    
    var fillOutTimer = Timer()
    var fillOutCompletion : CGFloat = 1

    @IBOutlet weak var sampleIcon: TaskIconWithLabel!
    @IBOutlet weak var fillInButton: UIButton!
    @IBOutlet weak var fillOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sampleIcon.setupWithRaw(name: "Mastery", newImage: UIImage(named: "mastery_logo"), goalColor: UIColor(red:0.96, green:0.74, blue:0.38, alpha:1.0))
        
        fillInButton.layer.borderWidth = 2
        fillInButton.layer.cornerRadius = 15.0
        fillInButton.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        
        fillOutButton.layer.borderWidth = 2
        fillOutButton.layer.cornerRadius = 15.0
        fillOutButton.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    }
    
    @IBAction func fillOut(_ sender: Any) {
        
        fillOutCompletion = 1.0
        fillOutTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateFillOutTimer), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func fillIn(_ sender: Any) {
        
        fillInCompletion = 0.0
        fillInTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateFillInTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateFillOutTimer() {
        
        if fillOutCompletion > 0.01 {
            
            fillOutCompletion = fillOutCompletion - 0.01
            sampleIcon.taskIcon.redrawRing(completion: fillOutCompletion)
            
        } else {
            fillOutTimer.invalidate()
            fillOutCompletion = 1.0
            sampleIcon.taskIcon.taskRing.layer.mask = nil
        }
        
        
        
    }
    
    @objc func updateFillInTimer() {
        
        if fillInCompletion < 1.0 {
            
            fillInCompletion = fillInCompletion + 0.01
            sampleIcon.taskIcon.redrawRing(completion: fillInCompletion)
            
        } else {
            fillInTimer.invalidate()
            fillInCompletion = 0.0
            sampleIcon.taskIcon.redrawRing(completion: 0.0)
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
