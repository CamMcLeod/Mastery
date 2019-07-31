//
//  OverviewViewController.swift
//  Mastery_iOS
//
//  Created by Cameron Mcleod on 2019-07-29.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit
import CoreData

protocol reloadFocusDelegate {
    
    func reloadFocusAfterSave()
    
}

class OverviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    //MARK: variables
    var taskID : UUID?
    var newTaskSessions : [(Date,Int)]?
    var task = Task()
    var endTime : Date?
    var bgColor : UIColor?
    var goalColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    var taskImage : UIImage?
    var newNotes : [String]?
    var tagList : [String]?
    var reloadDelegate : reloadFocusDelegate?

    //MARK: IB Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskIconView: TaskIcon!
    @IBOutlet weak var overviewTableLabel: UILabel!
    @IBOutlet weak var overviewTable: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    
    
    //MARK: View Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.overviewTable.delegate = self
        self.overviewTable.dataSource = self
        
        self.view.backgroundColor = self.bgColor
        
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
            self.tagList = taskFromID.tags
            print(taskFromID.taskDatesAndDurations)
            
        } catch {
            
            print("Oh no, there is no data to load")
        }
        
        // set up previous sessions


        
        // set up buttons
        setUpColors()
        if let image = taskImage {
            taskIconView.iconSetup(icon: image, iconColor: goalColor)
        }

    }
    
    // MARK: - Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return newTaskSessions!.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let unsavedSessions = newTaskSessions else {
            return tableView.dequeueReusableCell(withIdentifier: "unsavedSession") as! PreviousSessionCell
        }
        
        let row = indexPath.row
        if indexPath.section == 0 {
            let startEndCell = tableView.dequeueReusableCell(withIdentifier: "startEndCell") as! StartEndCell
            startEndCell.configure(startDate: unsavedSessions.last!.0, endDate: self.endTime ?? Date() color: goalColor)
            return startEndCell
        }
        else {
            let unsavedCell = tableView.dequeueReusableCell(withIdentifier: "unsavedSession") as! PreviousSessionCell
            unsavedCell.configure(with: unsavedSessions[row].0, duration: unsavedSessions[row].1, color: goalColor)
            return unsavedCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 2.0
        } else {
            return 0
        }

    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        
        if section == 0 {
            view.tintColor = goalColor
        }

    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let addNote = UITableViewRowAction(style: .normal, title: "Add Note") { (action, indexPath) in
            // edit item at indexPath
        }
        
        addNote.backgroundColor = goalColor
        
        return [addNote]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 {
            return false
        }
        else{
            return true
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y<=0) {
            scrollView.contentOffset = CGPoint.zero;
        }
    }
    
    // MARK: - Collection View
    
    
    
    // MARK: - Navigation
    
    @IBAction func cancelPressed(_ sender: Any) {
        
        if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
             dismiss(animated: true, completion: nil)
        }
    }

    
    //MARK: - Private Functions
    
    private func saveState() {
        
        task.tags = tagList
        
        if let notes = newNotes {
            if let taskNotes = task.notes {
                task.notes = taskNotes + notes
            }else {
                task.notes = notes
            }
        }
        
        if var previousSessions = task.taskDatesAndDurations {
            
            for session in self.newTaskSessions! {
                previousSessions[session.0] = session.1
                print(session.1)
            }
            task.taskDatesAndDurations = previousSessions
        } else {
            for session in self.newTaskSessions! {
                task.taskDatesAndDurations![session.0] = session.1
            }
        }
        
        PersistenceService.saveContext()
    }
    
    private func setUpColors() {
        
        overviewTable.layer.borderWidth = 5
        overviewTable.layer.borderColor = goalColor.cgColor
        overviewTable.layer.cornerRadius = 15.0
        
        overviewTableLabel.layer.borderWidth = 2
        overviewTableLabel.layer.borderColor = goalColor.cgColor
        
        taskNameLabel.textColor = goalColor
        
        let tintedSave = saveButton.imageView?.image!.withRenderingMode(.alwaysTemplate)
        saveButton.setImage(tintedSave, for: .normal)
        saveButton.tintColor = goalColor
        
    }
    
    //MARK: - Actions
    
    

    @IBAction func savePressed(_ sender: Any) {
        
        saveState()
        
        if reloadDelegate != nil {
            reloadDelegate?.reloadFocusAfterSave()
            saveButton.isEnabled = false
        }
        
    }
    
    

    
}
