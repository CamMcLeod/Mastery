//
//  GoalListTableViewController.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-23.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit
import CoreData

class GoalListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private let cellAspect = 1.25 as CGFloat
    
    @IBOutlet weak var tableView: UITableView!
    var goals = [Goal]()
    var valueToPass: Task?
    var goalToPassIndex: Int!
    var button: UIButton!
    var button2: UIButton!
    
    var goalToPass: Goal?
    var taskToPass: Task?
    
    var sectionForCell: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
//                let sortDescriptor = NSSortDescriptor(key: "dateOfBirth", ascending: false)
//                fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let goals =  try PersistenceService.context.fetch(fetchRequest)
            self.goals = goals
            print(goals.count)
            self.tableView.reloadData()
        } catch {
            print("Oh no, there is no data to load")
        }
    }
    
    @IBAction func addNewGoal(_ sender: UIButton) {
        performSegue(withIdentifier: "showTheGoal", sender: self)
    }
    
    var numberOfItems: Int!
    
    //    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        cell.collectionView.tag = indexPath.row
        cell.collectionView.reloadData()
        cell.name.text = goals[indexPath.row].name
        cell.name.backgroundColor = goals[indexPath.row].color
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? HomeTableViewCell else { return }
//                tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedGoal = goals[indexPath.section]
        goalToPass = selectedGoal
        performSegue(withIdentifier: "goalDetailSegue", sender: self)
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            guard let rows = goals[collectionView.tag].tasks else {return 0}
            return rows.count
        default:
            return 1
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "iconCell", for: indexPath) as! IconCollectionViewCell
            let selectedGoal = goals[collectionView.tag]
            if let values = selectedGoal.tasks?.allObjects {
                let value = values[indexPath.row] as! Task
                if let newImageData = value.image {
                    
                    cell.iconWithLabel.setupWithRaw(name: value.name, newImage: UIImage(data: newImageData as Data), goalColor: selectedGoal.color)
                }
                
                
                return cell
            }
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "taskCell", for: indexPath) as! AddTaskCollectionViewCell

            return cell
        }
        
        return collectionView.dequeueReusableCell(withReuseIdentifier: "taskCell", for: indexPath)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let selectedGoal = goals[collectionView.tag]
            if let values = selectedGoal.tasks?.allObjects {
                let value = values[indexPath.row] as! Task
                taskToPass = value
                performSegue(withIdentifier: "taskDetailSegue", sender: self)
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTaskDetail" {
            let controller = segue.destination as! DetailedTaskViewController
            controller.task = valueToPass
        } else if segue.identifier == "addNewTask" {
            //            let controller = segue.destination as! AddAnotherTaskViewController
            //            controller.goal = goals[goalToPassIndex]
        } else if segue.identifier == "showTheGoal" {
            
        }  else if segue.identifier == "goalDetailSegue" {
                        let controller = segue.destination as! GoalDetailViewController
                        controller.goal = goalToPass
        } else if segue.identifier == "taskDetailSegue" {
                        let controller = segue.destination as! TaskDetailViewController
                            controller.task = taskToPass
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let sideSpacing = layout.minimumInteritemSpacing * 2 + layout.sectionInset.left + layout.sectionInset.right
        let size = (self.view.frame.width - sideSpacing - 40) / 3
        return CGSize(width: size, height: size * cellAspect)
    }
}




