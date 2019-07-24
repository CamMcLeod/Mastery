//
//  AddGoalDetailsViewController.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-23.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class AddGoalDetailsViewController: UIViewController {
    
    var goalName: String?
    var purpose:  String?
    var purposeTwo: String?
    var purposeThree: String?
    
    @IBOutlet weak var dateOfBirth: UIDatePicker!
    @IBOutlet weak var deadline: UIDatePicker!
    

    override func viewDidLoad() {
        super.viewDidLoad()

//        guard let goalName = goalName,
//             let purpose = purpose,
//             let purposeTwo = purposeTwo,
//        let purposeThree = purposeThree else {return}
//        print(goalName, purpose, purposeTwo, purposeThree)

    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addPlan" {
            if let detailViewController = segue.destination as? AddPlanViewController {
                detailViewController.goal = saveGoalData()
            }
        }
        
    }
 
    func saveGoalData() -> Goal {
        let goal = Goal(context: PersistenceService.context)
        goal.id = UUID()
        goal.name = goalName
        goal.purpose = purpose
        goal.isComplete = false
        goal.dateOfBirth = dateOfBirth.date as NSDate
        goal.deadline?.append((deadline.date) as Date)
        PersistenceService.saveContext()
       return goal
    }

}
