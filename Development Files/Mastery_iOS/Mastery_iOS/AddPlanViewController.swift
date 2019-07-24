//
//  AddPlanViewController.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-23.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class AddPlanViewController: UIViewController {
    
    var goal: Goal?

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var purpose: UITextView!
    @IBOutlet weak var deadline: UIDatePicker!
    
    
    override func viewDidLoad() {
        print(goal)
        super.viewDidLoad()

        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTasks" {
            if let detailViewController = segue.destination as? AddTaskViewController {
                detailViewController.plan = saveGoalData()
            }
        }
        
    }
    
    func saveGoalData() -> Plan {
        
        let plan = Plan(context: PersistenceService.context)
        plan.id = UUID()
        plan.name = name.text
        plan.dateOfBirth = Date() as NSDate
        plan.isComplete = false
        plan.deadline?.append(deadline.date)
        plan.purpose = purpose.text
        goal?.addToPlans(plan)
        PersistenceService.saveContext()
        return plan
    }


}
