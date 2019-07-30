//
//  AddTaskViewController.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-23.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController, UITextFieldDelegate {
    
    var goal: Goal?
    
    @IBOutlet weak var imageIconView: UIView!
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    private var priority: Int16!
    private var taskDescription: String!
    private var timeEstimate: UISegmentedControl!
    private var deadline: Date!
    private var availability: [Bool]!
    
    var tagList: [String] = [String]()
    
    private var refreshCollectionView = 0 {
        didSet {
            let indexPath = IndexPath(item: 4, section: 0)
            tableView.reloadRows(at: [indexPath], with: .top)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let goal = goal else {return}
        print(goal)
        
        name.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let name = name.text,
            let rangeOfTextToReplace = Range(range, in: name) else {
                return false
        }
        let substringToReplace = name[rangeOfTextToReplace]
        let count = name.count - substringToReplace.count + string.count
        return count <= 30
    }
    
    
    func saveTask() {
        let task = Task(context: PersistenceService.context)
        task.name = name.text
        task.taskDescription = taskDescription
        task.id = UUID()
        task.deadline = deadline as NSDate?
        task.isComplete = false
        task.dateOfBirth = Date() as NSDate
        task.priority = priority
        task.tags = tagList
        task.daysAvailable = availability
        goal?.addToTasks(task)
        PersistenceService.saveContext()
    }
    
    @IBAction func goBackHome(_ sender: UIBarButtonItem) {
        print(name.text!)
        print(deadline!)
        print(priority!)
        print(taskDescription!)
        print(availability!)
        print(tagList)
        saveTask()
        navigationController?.popToRootViewController(animated: true)
    }
    
    
}

extension AddTaskViewController: UITableViewDelegate, UITableViewDataSource, GoalDescriptionCellDelegate, DatePickerTableViewCellDelegate, GoalPriorityTableCellDelegate, TaskAvailabilityCellDelegate {
    
    func selectedDates(daysOfWeek: [Bool]) {
        availability = daysOfWeek
    }
    
    
    func dateChanged(toDate date: Date) {
        deadline = date
    }
    
    func getPriority(priority: Int16) {
        self.priority = priority
    }
    
    
    
    func getValueForDescription(theDescription: String) {
        taskDescription = theDescription
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskDescriptionCell", for: indexPath) as! TaskDescriptionTableViewCell
            cell.delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskDeadlineCell", for: indexPath) as! TaskDeadlineTableViewCell
            cell.delegate = self
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskPriorityCell", for: indexPath) as! TaskPriorityTableViewCell
            cell.delegate = self
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskAvailabilityCell", for: indexPath) as! TaskAvailabilityTableViewCell
            cell.delegate = self
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskTagsCell", for: indexPath) as! TaskTagsTableViewCell
            cell.collectionView.reloadData()
            return cell
            
        default:
            return tableView.dequeueReusableCell(withIdentifier: "Cell")!
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension AddTaskViewController : UICollectionViewDelegate, UICollectionViewDataSource, TagsEmptyCollectionCellDelegate {
    
    
    func addTagToList(tagName: String) {
        tagList.append(tagName)
        if refreshCollectionView >= 2 {
            refreshCollectionView = 0
        } else {
            refreshCollectionView += 1
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < tagList.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "goalsCreatedTagCell", for: indexPath) as! TaskTagsCollectionViewCell
            cell.tagName.text = tagList[indexPath.row]
            return cell
        } else {
            
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "goalsEmptyTagCell", for: indexPath) as! EmptyTagCollectionViewCell
        cell.delegate = self
        return cell
    }
}




