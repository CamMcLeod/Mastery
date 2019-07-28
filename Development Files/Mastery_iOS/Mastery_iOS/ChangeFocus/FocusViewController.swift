//
//  FocusViewController.swift
//  Mastery_iOS
//
//  Created by Cameron Mcleod on 2019-07-27.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit
import CoreData

class FocusViewController: UIViewController {
    
    var taskID : UUID?
    var task = Task()
    var taskPredicate: NSPredicate?

    @IBOutlet weak var focusTestLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // TEST TASK
        let task1 = Task(context: PersistenceService.context)
        task1.name = "Be Cool"
        task1.taskDescription = "I just want to be everyone's friend and like have super cool parteeees."
        task1.isComplete = false
        task1.daysAvailable = Array.init(repeating: true, count: 7)
        task1.deadline = NSDate(timeIntervalSinceNow: 10000)
        task1.priority = Int16(7)
        task1.id = UUID()
        PersistenceService.saveContext()

        // Do any additional setup after loading the view.
        // UNCOMMENT TO UNLEASH FURY
        guard let id = self.taskID else {
            print("id not UIID")
            return
        }
            
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        fetchRequest.predicate = NSPredicate(format: "id == %@", argumentArray: [id])
        do {
            let taskFromID =  try PersistenceService.context.fetch(fetchRequest)[0]
            self.task = taskFromID
        } catch {
            print("Oh no, there is no data to load")
        }
        focusTestLabel.text = self.task.name
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
