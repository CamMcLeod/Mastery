//
//  TaskDetailViewController.swift
//  Mastery_iOS
//
//  Created by Marina Mona June McPeak on 2019-07-30.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class TaskDetailViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var task: Task?
    var tintColor = UIColor()
    
    @IBOutlet weak var taskTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tintColor = task!.goal!.color!
        self.navigationItem.rightBarButtonItem?.tintColor = tintColor
        
    
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
                    return 250
        } else if indexPath.row == 6 {
            return 250
        }
        
        return 80
        
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(task?.name)
        if let task = task {
            print(indexPath.row)
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "taskIconCell", for: indexPath) as! TaskDetailIconTableViewCell
                if let taskImage = task.image {
                    let newImage = UIImage(data: taskImage as Data)
                    let goalColor = task.goal!.color
                    cell.taskIconWithLabel.setupWithRaw(name: task.name, newImage: newImage, goalColor: goalColor)
                }
                
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "taskDescriptionCell", for: indexPath) as! TaskDetailDescriptionTableViewCell
                print(task.notes)
                if let taskD = task.taskDescription {
                    var tempString = ""
                    if let notes = task.notes {
                        for note in notes {
                            tempString = tempString + "\n" + note
                        }
                        cell.taskDescription.text = taskD + "\n" + tempString
                        return cell
                    }
                    cell.taskDescription.text = taskD
                }
                
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "taskParentCell", for: indexPath) as! TaskDetailParentTableViewCell
                cell.goalName.text = task.goal?.name
                cell.parentTitle.textColor = tintColor
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "taskDeadlineCell", for: indexPath) as! TaskDetailDeadlineTableViewCell
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMMM dd, YYYY"
                cell.taskDeadline.text = dateFormatter.string(for: task.deadline)
                cell.deadlineTitle.textColor = tintColor
                return cell
            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: "taskPriorityCell", for: indexPath) as! TaskDetailPriorityTableViewCell
                cell.taskPriority.text = "\(task.priority)"
                cell.priorityTitle.textColor = tintColor
                return cell
            case 5:
                let cell = tableView.dequeueReusableCell(withIdentifier: "taskAvailabilityCell", for: indexPath) as! TaskDetailAvailabilityTableViewCell
                guard let days = task.daysAvailable else {return cell}
                
                let colorArray = getDayColorForAvailability(days: days)
                cell.sundayIcon.textColor = colorArray[0]
                setBorder(available: days[0], label: cell.sundayIcon)
                cell.mondayIcon.textColor = colorArray[1]
                setBorder(available: days[1], label: cell.mondayIcon)
                cell.tuesdayIcon.textColor = colorArray[2]
                setBorder(available: days[2], label: cell.tuesdayIcon)
                cell.wednesdayIcon.textColor = colorArray[3]
                setBorder(available: days[3], label: cell.wednesdayIcon)
                cell.thursdayIcon.textColor = colorArray[4]
                setBorder(available: days[4], label: cell.thursdayIcon)
                cell.fridayIcon.textColor = colorArray[5]
                setBorder(available: days[5], label: cell.fridayIcon)
                cell.saturdayIcon.textColor = colorArray[6]
                setBorder(available: days[6], label: cell.saturdayIcon)

                cell.availabilityTitle.textColor = tintColor
                return cell
            case 6:
                let cell = tableView.dequeueReusableCell(withIdentifier: "taskTagsCell", for: indexPath) as! TaskDetailTagsTableViewCell
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "taskDescriptionCell", for: indexPath) as! TaskDetailDescriptionTableViewCell
                return cell
            }
            

        }
        else {
            return tableView.dequeueReusableCell(withIdentifier: "goalNameCell")!
        }
    }
    
    func getDayColorForAvailability(days: [Bool]) -> [UIColor] {
        let colorArray = days.map { (available) -> UIColor in
            if available {
                return UIColor.darkText
            } else {
                return UIColor.lightGray
            }
        }
        return colorArray
    }
    
    func setBorder(available: Bool, label: UILabel!) {
        
        if available {
            label.layer.cornerRadius = label.frame.width / 2
            label.layer.borderWidth = 3.0
            label.layer.backgroundColor = UIColor.clear.cgColor
            label.layer.borderColor = tintColor.cgColor
        }
        
    }
    
}

extension TaskDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = task?.tags?.count else {return 0}
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "displayTaskTags", for: indexPath) as! TagCreatedTaskDetailCollectionViewCell
        guard let tagname = task?.tags?[indexPath.row] else {return cell}
        cell.tagName.text = tagname
        return cell
        
    }
    
    
}
