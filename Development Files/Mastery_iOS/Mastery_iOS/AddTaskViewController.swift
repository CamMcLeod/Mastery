//
//  AddTaskViewController.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-23.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    var plan: Plan?
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var priority: UISegmentedControl!
    @IBOutlet weak var taskDescription: UITextView!
    @IBOutlet weak var timeEstimate: UISegmentedControl!
    @IBOutlet weak var deadline: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(plan)

        // Do any additional setup after loading the view.
    }
    

    @IBAction func saveTask(_ sender: UIButton) {
        let task = Task(context: PersistenceService.context)
        task.name = name.text
        task.id = UUID()
        task.taskDescription = taskDescription.text
        task.isComplete = false
        task.dateOfBirth = Date() as NSDate
        task.timeEstimate = (timeEstimate.titleForSegment(at: timeEstimate.selectedSegmentIndex)! as NSString).floatValue
        task.deadline = deadline.date as NSDate
        task.priority = priority.titleForSegment(at: priority.selectedSegmentIndex)
        plan?.addToTasks(task)
        PersistenceService.saveContext()
    }
    
    @IBAction func goBackHome(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
}
