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
            print(goals.count)
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
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 1
        let labelWidth = tableView.frame.size.width
        let label = UILabel(frame: CGRect(x: tableView.center.x , y: tableView.sectionHeaderHeight / 2 , width: labelWidth, height: 25))
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.center.x = tableView.center.x
        label.textAlignment = .center
//        label.center.x =
//        label.text = goals[section].name?.capitalized
        
        button = UIButton(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width / 2 , height: 50))
//        button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        button.setTitle("\(goals[section].name!.capitalized) ▴", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.center.x = tableView.center.x
        button.tag = section
        button.contentHorizontalAlignment = .center
        view.addSubview(button)
//        button.addSubview(label)
       
        
        button2 = UIButton(frame: CGRect(x: (tableView.frame.size.width) - (tableView.frame.size.width / 4 ) , y: 0, width: tableView.frame.size.width / 4, height: 50))
//        button2.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        button2.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button2.setTitle("▻", for: .normal)
        button2.tag = section
        button2.addTarget(self, action: #selector(showGoalDetails), for: .touchUpInside)
        view.addSubview(button2)
        return view
    }
    
    @objc func showGoalDetails(button: UIButton) {
        print("I have been touched")
        goalToPassIndex = button2.tag
        performSegue(withIdentifier: "showGoalDetails", sender: self)
    }
    
    var numberOfItems: Int!

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return goals.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        cell.collectionView.tag = indexPath.section
        cell.collectionView.reloadData()
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
            cell.imageView.image = UIImage(named: "falcon")
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
        } else if segue.identifier == "showGoalDetails" {
            
        }
    }
}



