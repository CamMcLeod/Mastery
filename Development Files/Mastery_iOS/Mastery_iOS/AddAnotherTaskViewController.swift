//
//  AddAnotherTaskViewController.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-25.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class AddAnotherTaskViewController: UIViewController {
    
    var goal: Goal?
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var priority: UISegmentedControl!
    @IBOutlet weak var taskDescription: UITextView!
    @IBOutlet weak var timeEstimate: UISegmentedControl!
    @IBOutlet weak var deadline: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()

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
        goal?.addToTasks(task)
        PersistenceService.saveContext()
        
    }
    
//    navigationController?.popToRootViewController(animated: true)

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
