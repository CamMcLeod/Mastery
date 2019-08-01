//
//  TaskDetailViewController.swift
//  Mastery_iOS
//
//  Created by Marina Mona June McPeak on 2019-07-30.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class TaskDetailViewController : UIViewController {
    
    var task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let task = task else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskDescriptionCell", for: indexPath)
            cell.detailTextLabel?.text = "No task exists!"
            return cell
        }
        
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
             cell.detailTextLabel?.text = task.taskDescription
            return cell
        case 2:
             let cell = tableView.dequeueReusableCell(withIdentifier: "taskParentCell", for: indexPath) as! TaskDetailParentTableViewCell
             cell.parentTitle.text = task.goal?.name
            return cell
        case 3:
             let cell = tableView.dequeueReusableCell(withIdentifier: "taskDeadlineCell", for: indexPath) as! TaskDetailDeadlineTableViewCell
             let dateFormatter = DateFormatter()
             dateFormatter.dateFormat = "MMMM dd, YYYY"
             cell.taskDeadline.text = dateFormatter.string(for: task.deadline)
            return cell
        case 4:
             let cell = tableView.dequeueReusableCell(withIdentifier: "taskPriorityCell", for: indexPath) as! TaskDetailPriorityTableViewCell
             cell.taskPriority.text = "\(task.priority)"
            return cell
        case 5:
             let cell = tableView.dequeueReusableCell(withIdentifier: "taskAvailabilityCell", for: indexPath) as! TaskDetailAvailabilityTableViewCell
             guard let days = task.daysAvailable else {return cell}
             cell.sundayIcon.text = "\(days[0])"
              cell.mondayIcon.text = "\(days[1])"
              cell.tuesdayIcon.text = "\(days[2])"
              cell.wednesdayIcon.text = "\(days[3])"
              cell.thursdayIcon.text = "\(days[4])"
              cell.fridayIcon.text = "\(days[5])"
              cell.saturdayIcon.text = "\(days[6])"
            return cell
        case 6:
             let cell = tableView.dequeueReusableCell(withIdentifier: "taskTagsCell", for: indexPath) as! TaskDetailTagsTableViewCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "taskDescriptionCell", for: indexPath) as! TaskDetailDescriptionTableViewCell
            return cell
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
