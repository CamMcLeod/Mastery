//
//  AddGoalDetailsViewController.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-23.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class CreateNewGoalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DatePickerTableViewCellDelegate,  GoalDescriptionCellDelegate, GoalHoursTableCellDelegate, GoalPriorityTableCellDelegate, GoalNameCellDelegate {
   
    
   
    // protocol methods to pass values from custom table cells decided by user to Goal object
  
    
    func getValueForName(theName: String) {
        tmpName  = theName
    }
    
    func getValueForDescription(theDescription: String) {
        tmpDescription = theDescription
    }
    
    func dateChanged(toDate date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, YYYY"
        tmpDateAsString = dateFormatter.string(from: date)
        tmpDate = date
    }
    
    func getHours(hours: Float) {
        tmpHours = hours
    }
    
    func getPriority(priority: Int16) {
        tmpPriority = priority
    }
    
   private var pickerisHidden: Bool = true
    func showStatusPickerCell(datePicker: UIDatePicker) {
        UIView.animate(withDuration: 0.3, animations: {
            () -> Void in
            datePicker.isHidden = !datePicker.isHidden
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        })
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var tagList: [String] = [String]()
    
    private var refreshCollectionView = 0 {
        didSet {
            let indexPath = IndexPath(item: 4, section: 0)
            tableView.reloadRows(at: [indexPath], with: .top)
        }
    }
    
    var colorArray: [UIColor] = [UIColor(red:0.49, green:0.47, blue:0.73, alpha:1.0),
                                 UIColor(red:0.91, green:0.44, blue:0.32, alpha:1.0),
                                 UIColor(red:0.35, green:0.76, blue:0.76, alpha:1.0),
                                 UIColor(red:0.55, green:0.70, blue:0.41, alpha:1.0),
                                 UIColor(red:0.96, green:0.74, blue:0.38, alpha:1.0)]
    
    private var tmpName: String?
    private var tmpDescription: String?
    private var tmpDateAsString: String!
    private var tmpDate: Date?
    private var tmpHours: Float?
    private var tmpPriority: Int16?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "goalNameCell", for: indexPath) as! GoalNameTableViewCell
         
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "goalDescriptionCell", for: indexPath) as! GoalDescriptionTableViewCell
            cell.delegate = self
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "goalPriorityCell", for: indexPath) as! GoalPriorityTableViewCell
            cell.delegate = self
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "goalDeadlineCell", for: indexPath) as! GoalDeadlineTableViewCell
            cell.delegate = self
            
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "goalHoursCell", for: indexPath) as! GoalHoursTableViewCell
            cell.delegate = self
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "goalTagsCell", for: indexPath) as! GoalTagsTableViewCell
            cell.collectionView.reloadData()
            return cell
            
        default:
            return tableView.dequeueReusableCell(withIdentifier: "Cell")!
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            let height: CGFloat = pickerisHidden ? 40.0 : 210
            return height
        }
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dateIndexPath = IndexPath(row: 1, section: 0)
        if dateIndexPath == indexPath {
            pickerisHidden = !pickerisHidden
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTask" {
            if let detailViewController = segue.destination as? CreateFirstTaskViewController {
                detailViewController.goal = saveGoalData()
            }
        }
        
    }
    
    func saveGoalData() -> Goal {
        let goal = Goal(context: PersistenceService.context)
        goal.id = UUID()
        goal.name = tmpName
        goal.goalDescription = tmpDescription
        goal.isComplete = false
        goal.hoursEstimate = tmpHours ?? 0.0
        goal.hoursCompleted = 0.0
        goal.priority = tmpPriority ?? 1
        goal.dateOfBirth = Date() as NSDate
        goal.deadline = [tmpDate] as? [Date]
        goal.color = getColorFromUserDefaults(colorArray: colorArray)
        goal.tags = tagList
        PersistenceService.saveContext()
        print("yoyo\n\n\n\n\(goal)")
        return goal
    }
    
    
    func getColorFromUserDefaults(colorArray: [UIColor]) -> UIColor {
        if let colorIndex  = UserDefaults.standard.object(forKey: "goalColorIndex") as? Int {
            if colorIndex == colorArray.count - 1 {
                UserDefaults.standard.set(0, forKey: "goalColorIndex")
                return colorArray[0]
            } else {
                UserDefaults.standard.set(colorIndex + 1, forKey: "goalColorIndex")
                return colorArray[colorIndex + 1]
            }
        }
        else {
            UserDefaults.standard.set(0, forKey: "goalColorIndex")
            return colorArray[0]
        }
    }
    
    
}


extension CreateNewGoalViewController: UICollectionViewDelegate, UICollectionViewDataSource, EmptyTagCollectionViewCellDelegate{
    
    
    func addTagToList(tagName: String) {
        tagList.append(tagName)
        print(tagList)
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "goalTagCreatedCell", for: indexPath) as! TagCreatedGoalCollectionViewCell
            cell.tagName.text = tagList[indexPath.row]
            return cell
        } else {
            
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "goalTagEmptyCell", for: indexPath) as! TagEmptyGoalCollectionViewCell
        cell.delegate = self
        return cell
    }
    
    @IBAction func cancelDownload(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
        
    }
    
}

