//
//  AddTaskViewController.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-23.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class CreateFirstTaskViewController: UIViewController {
    
    var goal: Goal?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    private var image: NSData?
    private var taskName: String?
    private var priority: Int16?
    private var taskDescription: String?
    private var timeEstimate: UISegmentedControl!
    private var deadline: Date?
    private var availability: [Bool]?
    var tintColor = UIColor()
    
    private var pickerisHidden: Bool = true
    var tagList: [String] = [String]()
    
    private var refreshCollectionView = 0 {
        didSet {
            let indexPath = IndexPath(item: 6, section: 0)
            tableView.reloadRows(at: [indexPath], with: .top)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let goalTags = goal?.tags else {return}
        tagList.append(contentsOf: goalTags)
        tintColor = goal!.color!
        saveButton.isEnabled = false
        // Do any additional setup after loading the view.
    }
    
    
    func saveTask() {
        let task = Task(context: PersistenceService.context)
        task.name = taskName ?? "Add name here"
        task.taskDescription = taskDescription ?? "Add description here"
        task.id = UUID()
        task.deadline = deadline as NSDate?
        task.isComplete = false
        task.dateOfBirth = Date() as NSDate
        task.priority = priority ?? 1
        task.tags = tagList
        task.image = image
        task.daysAvailable = availability
        goal?.addToTasks(task)
        PersistenceService.saveContext()
        print(task)
    }
    
    @IBAction func goBackHome(_ sender: UIBarButtonItem) {
        saveTask()
//        let vc = GoalListTableViewController()
//        self.present(vc, animated: true, completion: nil)
//        navigationController?.popToRootViewController(animated: true)
       dismiss(animated: true, completion: nil)
        
    }
    
    
}

extension CreateFirstTaskViewController: UITableViewDelegate, UITableViewDataSource, TaskIconCellDelegate, GoalNameCellDelegate, GoalDescriptionCellDelegate, DatePickerTableViewCellDelegate, GoalPriorityTableCellDelegate, TaskAvailabilityCellDelegate {
    
    func getIcon(icon: TaskIcon) {
        
        if let iconPNG = icon.iconImage.image {
            image = iconPNG.pngData() as NSData?
        } else {
            image = UIImage(named: "NewGoal_Button")?.pngData() as NSData?
        }
    }

    func getValueForName(theName: String) {
        taskName = theName
        if taskName != nil && deadline != nil {
            saveButton.isEnabled = true
        }
    }
    
    func selectedDates(daysOfWeek: [Bool]) {
        availability = daysOfWeek
    }
    
    
    func dateChanged(toDate date: Date) {
        deadline = date
        if taskName != nil && deadline != nil {
            saveButton.isEnabled = true
        }
    }
    
    func getPriority(priority: Int16) {
        self.priority = priority
    }
    
    
    
    func getValueForDescription(theDescription: String) {
        taskDescription = theDescription
    }
    
    
    func showStatusPickerCell(datePicker: UIDatePicker) {
        datePicker.isHidden = !datePicker.isHidden

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskIconCell", for: indexPath) as! TaskIconTableViewCell
            cell.goalColor = goal?.color
            cell.delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskNameCell", for: indexPath) as! TaskNameTableViewCell
            cell.delegate = self
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskDescriptionCell", for: indexPath) as! TaskDescriptionTableViewCell
            cell.delegate = self
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskDeadlineCell", for: indexPath) as! TaskDeadlineTableViewCell
            cell.delegate = self
            
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskPriorityCell", for: indexPath) as! TaskPriorityTableViewCell
            cell.delegate = self
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskAvailabilityCell", for: indexPath) as! TaskAvailabilityTableViewCell
            cell.delegate = self
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskTagsCell", for: indexPath) as! TaskTagsTableViewCell
            cell.collectionView.reloadData()
            return cell
            
        default:
            return tableView.dequeueReusableCell(withIdentifier: "cell")!
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3 {
            let height: CGFloat = pickerisHidden ? 40.0 : 210
            return height
        }
        return 150
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dateIndexPath = IndexPath(row: 3, section: 0)
        tableView.deselectRow(at: indexPath, animated: false)
        if dateIndexPath == indexPath {
            pickerisHidden = !pickerisHidden
            
        }
        let currentOffset = self.tableView.contentOffset
        //        UIView.setAnimationsEnabled(false)
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: [IndexPath(row: 3, section: 0)], with: .none)
        tableView.endUpdates()
        //        UIView.setAnimationsEnabled(true)
        self.tableView.setContentOffset(currentOffset, animated: true)
    }
    
}

extension CreateFirstTaskViewController : UICollectionViewDelegate, UICollectionViewDataSource, EmptyTagCollectionViewCellDelegate {
    
    
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "taskCreatedTagCell", for: indexPath) as! TagCreatedTaskCollectionViewCell
            cell.tagName.text = tagList[indexPath.row]
            return cell
        } else {
            
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "taskEmptyTagCell", for: indexPath) as! TagEmptyTaskCollectionViewCell
        cell.delegate = self
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "selectIcon":
            let taskIconCell = sender as! TaskIconTableViewCell
            let selectIconPopover = segue.destination as! SelectIconPopoverViewController
            selectIconPopover.iconDelegate = taskIconCell
            selectIconPopover.incomingIcon = taskIconCell.taskIcon.iconImage.image
            selectIconPopover.goalColor = goal!.color ?? #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            
        default:
            break
        }

    }
    
}




