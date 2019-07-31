//
//  GoalDetailViewController.swift
//  Mastery_iOS
//
//  Created by Marina Mona June McPeak on 2019-07-30.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class GoalDetailViewController : UIViewController, UITableViewDataSource, UITableViewDelegate, GoalDetailNameCellDelegate, GoalDetailDescriptionCellDelegate, GoalDetailDeadlineCellDelegate, GoalDetailPriorityCellDelegate, GoalDetailHoursCellDelegate {
    
    func getValueForName(name: String) {
        tmpName = name
    }
    
    func getValueForDescription(description: String) {
        tmpDescription = description
    }
    
    func getValueForDeadline(date: Date) {
        tmpDate = date
    }
    
    func getPriority(priority: Int16) {
        tmpPriority = priority
    }
    
    func getHours(hours: Float) {
        tmpHours = hours
    }
    
    private var tmpName: String?
    private var tmpDescription: String?
    private var tmpDate: Date?
    private var tmpDateAsString: String!
    private var tmpPriority: Int16?
    private var tmpHours: Float?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "goalNameCell", for: indexPath) as! GoalDetailNameTableViewCell
            cell.delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "goalDescriptionCell", for: indexPath) as! GoalDetailDescriptionTableViewCell
            cell.delegate = self
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "goalDeadlineCell", for: indexPath) as! GoalDetailDeadlineTableViewCell
            cell.delegate = self
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "goalPriorityCell", for: indexPath) as! GoalDetailPriorityTableViewCell
            cell.delegate = self
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "goalHoursCell", for: indexPath) as! GoalDetailHoursTableViewCell
            cell.delegate = self
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "goalTagsCell", for: indexPath) as! GoalDetailTagsTableViewCell
            return cell
        default:
            return tableView.dequeueReusableCell(withIdentifier: "cell")!
        }
    }
    
}

