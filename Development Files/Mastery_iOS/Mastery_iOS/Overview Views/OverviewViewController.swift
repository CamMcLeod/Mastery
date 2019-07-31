//
//  OverviewViewController.swift
//  Mastery_iOS
//
//  Created by Cameron Mcleod on 2019-07-29.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit
import CoreData

class OverviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    //MARK: variables
    var taskID : UUID?
    var newTaskSessions : [(Date,Int)]?
    var task = Task()
    var endTime : Date?
    var bgColor : UIColor?

    
    //MARK: IB Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskIconView: UIView!
    @IBOutlet weak var TaskTestLabel: UILabel!
    @IBOutlet weak var overviewTableLabel: UILabel!
    @IBOutlet weak var overviewTable: UITableView!
    
    
    //MARK: View Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.overviewTable.delegate = self
        self.overviewTable.dataSource = self

        overviewTable.layer.borderWidth = 5
        overviewTable.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.4352941176, blue: 0.3176470588, alpha: 1)
        overviewTable.layer.cornerRadius = 15.0
        
        overviewTableLabel.layer.borderWidth = 2
        overviewTableLabel.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.4352941176, blue: 0.3176470588, alpha: 1)
        
        // make sure id is UUID
        guard let id = self.taskID else {
            print("id not UIID")
            return
        }
        
        // fetch task from UUID
        
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        fetchRequest.predicate = NSPredicate(format: "id == %@", argumentArray: [id])
        
        do {
            let taskFromID =  try PersistenceService.context.fetch(fetchRequest)[0]
            self.task = taskFromID
            
        } catch {
            
            print("Oh no, there is no data to load")
        }
        
        // set up previous sessions


        
        // set up buttons

    }
    
    // MARK: - Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return newTaskSessions!.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let unsavedSessions = newTaskSessions else {
            return tableView.dequeueReusableCell(withIdentifier: "unsavedSession") as! PreviousSessionCell
        }
        
        let row = indexPath.row
        if indexPath.section == 0 {
            let startEndCell = tableView.dequeueReusableCell(withIdentifier: "startEndCell") as! StartEndCell
            startEndCell.configure(startDate: unsavedSessions.last!.0, endDate: self.endTime ?? Date())
            return startEndCell
        }
        else {
            let unsavedCell = tableView.dequeueReusableCell(withIdentifier: "unsavedSession") as! PreviousSessionCell
            unsavedCell.configure(with: unsavedSessions[row].0, duration: unsavedSessions[row].1)
            return unsavedCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2.0
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.4352941176, blue: 0.3176470588, alpha: 1)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y<=0) {
            scrollView.contentOffset = CGPoint.zero;
        }
    }
    
    // MARK: - Collection View
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - Actions

    @IBAction func savePressed(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
}
