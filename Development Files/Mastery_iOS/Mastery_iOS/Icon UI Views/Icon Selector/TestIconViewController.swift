//
//  TestIconViewController.swift
//  Mastery_iOS
//
//  Created by Cameron Mcleod on 2019-07-31.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class TestIconViewController: UIViewController, IconSaveDelegate  {

    @IBOutlet weak var taskIconTest: TaskIcon!
    var goalColor = UIColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        taskIconTest.iconSetup(icon: UIImage(named: "NewGoal_Button"), iconColor: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1))
        goalColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        print(goalColor)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "presentIcons":
            taskIconTest.animate()
            let nextVC = segue.destination as! SelectIconPopoverViewController
            nextVC.incomingIcon = taskIconTest.iconImage.image
            nextVC.iconDelegate = self
            nextVC.goalColor = goalColor
        default:
            fatalError()
        }
    }
    
    func setNewImage(image: UIImage) {
        taskIconTest.iconSetup(icon: image, iconColor: goalColor)
    }

}
