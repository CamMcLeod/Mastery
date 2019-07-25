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
    var valueToPass: Plan?
    
    
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
        let label = UILabel(frame: CGRect(x: 10, y: tableView.sectionHeaderHeight / 2 , width: tableView.frame.size.width, height: 25))
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = goals[section].name
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        button.backgroundColor = #colorLiteral(red: 0.462745098, green: 0.8392156863, blue: 1, alpha: 0.4490582192)
        button.setTitle("－", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.tag = section
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        button.contentHorizontalAlignment = .right
        view.addSubview(button)
        button.addSubview(label)
        return button
    }
    
    var numberOfItems: Int!
    
    @objc func handleExpandClose(button: UIButton) {
        let section = button.tag
        var indexPaths = [IndexPath]()
        if let plans = goals[section].plans?.allObjects {
            for row in plans.indices {
                let indexPath = IndexPath(row: 0, section: section)
                indexPaths.append(indexPath)
            }
             numberOfItems = plans.count
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
        cell.numberOfPlans = numberOfItems
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedGoal = goals[indexPath.section]
//        if let values = selectedGoal.plans?.allObjects {
//            let value = values[indexPath.row] as! Plan
//            valueToPass = value
//            performSegue(withIdentifier: "showPlan", sender: self)
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if goals[section].opened == true {
            guard let rows = goals[section].plans else {return 0}
            return 5
            
//        } else {
//            return 0
//        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "iconCell", for: indexPath) as! IconCollectionViewCell
        cell.imageView.image = UIImage(named: "dawn-3358468_1920")
        return cell
    }
    


/*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPlan" {
            let controller = segue.destination as! DetailedPlanViewController
            controller.plan = valueToPass
            
        }
    }
 

}


