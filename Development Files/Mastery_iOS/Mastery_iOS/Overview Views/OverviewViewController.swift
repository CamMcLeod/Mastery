//
//  OverviewViewController.swift
//  Mastery_iOS
//
//  Created by Cameron Mcleod on 2019-07-29.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit
import CoreData

class OverviewViewController: UIViewController {

    //MARK: variables
    var taskID : UUID?
    var newTaskSessions : [(Date,Int)]?
    var task = Task()
    var endTime : Date?
    var bgColor : UIColor?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // make sure id is UUID
        guard let id = self.taskID else {
            print("id not UIID")
            return
        }
        
        // fetch task from UUID
        
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        fetchRequest.predicate = NSPredicate(format: "id == %@", argumentArray: [id])
        
        do {
            let taskFromID =  try PersistenceService.context.fetch(fetchRequest)[0]
            self.task = taskFromID
            
        } catch {
            
            print("Oh no, there is no data to load")
        }
        
        // set up previous sessions


        
        // set up buttons

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
