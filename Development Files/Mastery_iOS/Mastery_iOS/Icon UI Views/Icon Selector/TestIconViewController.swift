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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        taskIconTest.iconSetup(icon: UIImage(named: "Settings_Icon"), iconColor: #colorLiteral(red: 0.9058823529, green: 0.4352941176, blue: 0.3176470588, alpha: 1))
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
            let nextVC = segue.destination as! SelectIconPopoverViewController
            nextVC.incomingIcon = taskIconTest.iconImage.image
            nextVC.iconDelegate = self
        default:
            fatalError()
        }
    }
    
    func setNewImage(image: UIImage) {
        taskIconTest.iconSetup(icon: image, iconColor: #colorLiteral(red: 0.9058823529, green: 0.4352941176, blue: 0.3176470588, alpha: 1))
    }

}
