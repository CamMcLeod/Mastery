//
//  DetailedPlanViewController.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-24.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class DetailedPlanViewController: UIViewController {
    
    @IBOutlet var showDetails: UILabel!
     var plan: Plan?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let plan = plan else {return}
        guard let tasks = plan.tasks?.allObjects else {return}
        let task = tasks[0] as! Task
        showDetails.text = task.name!
        
        print(plan.name!, plan.purpose!)
        
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
