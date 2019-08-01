//
//  GoalDetailViewController.swift
//  Mastery_iOS
//
//  Created by Marina Mona June McPeak on 2019-07-30.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class GoalDetailViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var goal: Goal?
    var tintColor = UIColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tintColor = goal!.color!
        self.navigationItem.rightBarButtonItem?.tintColor = tintColor
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return 200
        }
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let goal = goal else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.detailTextLabel?.text = "Nothing to see here"
            return cell         }
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "goalNameCell", for: indexPath) as! GoalDetailNameTableViewCell
           cell.goalName.text = goal.name
            cell.goalName.textColor = tintColor
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "goalDescriptionCell", for: indexPath) as! GoalDetailDescriptionTableViewCell
            cell.goalDescription.text = goal.goalDescription
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "goalDeadlineCell", for: indexPath) as! GoalDetailDeadlineTableViewCell
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM dd, YYYY"
            cell.goalDeadlineDate.text = dateFormatter.string(for: goal.deadline?.last)
            cell.descriptionTitle.textColor = tintColor
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "goalPriorityCell", for: indexPath) as! GoalDetailPriorityTableViewCell
            cell.goalPriority.text = "\(goal.priority)"
            cell.priorityTitle.textColor = tintColor
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "goalHoursCell", for: indexPath) as! GoalDetailHoursTableViewCell
            cell.goalHours.text = "\(goal.hoursEstimate)"
            cell.hoursTitle.textColor = tintColor
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "goalTagsCell", for: indexPath) as! GoalDetailTagsTableViewCell
            cell.tagsTitle.textColor = tintColor
            return cell
        default:
            return tableView.dequeueReusableCell(withIdentifier: "cell")!
        }
    }
    
}

extension GoalDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = goal?.tags?.count else {return 0}
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "displayGoalTags", for: indexPath) as! TagCreatedGoalDetailCollectionViewCell
        guard let goalName = goal?.tags?[indexPath.row] else {return cell}
        cell.tagTitle.text = goalName
        return cell
    }
    
    
}
