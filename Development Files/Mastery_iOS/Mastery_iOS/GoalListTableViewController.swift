//
//  GoalListTableViewController.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-23.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit
import CoreData

class GoalListTableViewController: UITableViewController, UICollectionViewDataSource, UICollectionViewDelegate {
   
    
    
    var goals = [Goal]()
    var valueToPass: Task?
    var goalToPassIndex: Int!
    var button: UIButton!
    var button2: UIButton!
    
    var sectionForCell: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
      
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        //        let sortDescriptor = NSSortDescriptor(key: "deadline", ascending: false)
        //        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let goals =  try PersistenceService.context.fetch(fetchRequest)
            self.goals = goals
//            print(goals.count)
            self.tableView.reloadData()
        } catch {
            print("Oh no, there is no data to load")
        }
    }
  
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        let labelWidth = tableView.frame.size.width
        let label = UILabel(frame: CGRect(x: tableView.center.x , y: tableView.sectionHeaderHeight / 2 , width: labelWidth, height: 25))
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.center.x = tableView.center.x
        label.textAlignment = .center
//        label.center.x =
        label.text = goals[section].name
        
        button = UIButton(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width - 60 , height: 50))
        button.backgroundColor = #colorLiteral(red: 0.462745098, green: 0.8392156863, blue: 1, alpha: 0.4490582192)
        button.setTitle("－", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.tag = section
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        button.contentHorizontalAlignment = .center
        view.addSubview(button)
        button.addSubview(label)
       
        
        button2 = UIButton(frame: CGRect(x: tableView.frame.size.width - 60, y: 0, width: 60, height: 50))
        button2.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button2.setTitle("Add Task", for: .normal)
        button2.tag = section
        button2.addTarget(self, action: #selector(addTask), for: .touchUpInside)
        view.addSubview(button2)
        return view
    }
    
    @objc func addTask(button: UIButton) {
        print("I have been touched")
        goalToPassIndex = button2.tag
        performSegue(withIdentifier: "addTask", sender: self)
    }
    
    var numberOfItems: Int!
    
    @objc func handleExpandClose(button: UIButton) {
        let section = button.tag
        var indexPaths = [IndexPath]()
        if let tasks = goals[section].tasks?.allObjects {
            for row in tasks.indices {
                let indexPath = IndexPath(row: 0, section: section)
                indexPaths.append(indexPath)
            }
             numberOfItems = tasks.count
        }
        
      
        
        let isExpanded = goals[section].opened
        goals[section].opened = !isExpanded
        button.setTitle(isExpanded ? "＋" :"－", for: .normal)
        if isExpanded {
            
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return goals.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if goals[section].opened == true {
//            guard let rows = goals[section].plans else {return 0}
            return 1

        } else {
            return 0
        }
       
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        cell.collectionView.tag = indexPath.section
        cell.collectionView.reloadData()
        sectionForCell = indexPath.section
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        guard let tableViewCell = cell as? HomeTableViewCell else { return }
//        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
//    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedGoal = goals[indexPath.section]
//        if let values = selectedGoal.plans?.allObjects {
//            let value = values[indexPath.row] as! Plan
//            valueToPass = value
//            performSegue(withIdentifier: "showPlan", sender: self)
//        }
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            guard let rows = goals[collectionView.tag].tasks else {return 0}
            return rows.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "iconCell", for: indexPath) as! IconCollectionViewCell
        let selectedGoal = goals[collectionView.tag]
        if let values = selectedGoal.tasks?.allObjects {
            let value = values[indexPath.row] as! Task
            cell.imageView.image = UIImage(named: "dawn-3358468_1920")
            cell.name.text = value.name
            print(value.name!)
          
        }
        
        return cell
    }
    


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showTaskDetail", sender: self)
    }
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTaskDetail" {
            let controller = segue.destination as! DetailedTaskViewController
            controller.task = valueToPass
            
        } else if segue.identifier == "addTask" {
            let controller = segue.destination as! AddAnotherTaskViewController
            controller.goal = goals[goalToPassIndex]
        }
    }
 

}


