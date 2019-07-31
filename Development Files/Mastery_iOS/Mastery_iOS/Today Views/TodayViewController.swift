//
//  TodayViewController.swift
//  Mastery_iOS
//
//  Created by Cameron Mcleod on 2019-07-27.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

private let cellAspect = 1.2 as CGFloat

class TodayViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate{
    
    var tasks = [Task]()
    var todayTasks = [Task]()
    var allIcons: [UIImage] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var switchToGoalsButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Do any additional setup after loading the view.
        
        // UNCOMMENT TO UNLEASH FURY
//        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        
//        do {
//            let tasks =  try PersistenceService.context.fetch(fetchRequest)
//            self.tasks = tasks
//            print(tasks.count)
//        } catch {
//            print("Oh no, there is no data to load")
//        }

        // TEST WITH NO DATA - COMMENT OUT WITH ACTIVE DATABASE
        //.............
        
        guard let bundleURL = Bundle.main.url(forResource: "TaskIcons", withExtension: "bundle") else { return }
        guard let bundle = Bundle(url: bundleURL) else { return }
        guard let imageURLs = bundle.urls(forResourcesWithExtension: ".png", subdirectory: nil) else { return }
        
        for imageURL in imageURLs {
            guard let image = UIImage(contentsOfFile: imageURL.path) else { continue }
            allIcons.append(image)
        }
        
        let goal = Goal(context: PersistenceService.context)
        goal.id = UUID()
        goal.name = "dfefef"
        goal.goalDescription = "Dfefefe"
        goal.isComplete = false
        goal.hoursEstimate = 1000
        goal.hoursCompleted = 0.0
        goal.priority = 2
        goal.dateOfBirth = Date() as NSDate
        goal.deadline = [Date()]
        goal.color = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        goal.tags = ["stinky", "woof"]
        PersistenceService.saveContext()
        
        for i in 1...20 {
            
            let task1 = Task(context: PersistenceService.context)
            task1.name = "Be Cool = " + String(i)
            task1.isComplete = i % 2 == 0 ? true : false
            task1.daysAvailable = Array.init(repeating: true, count: 7)
            task1.deadline = NSDate(timeIntervalSinceNow: -10000 * Double(i))
            task1.priority = Int16((i % 10) + 1)
            task1.daysAvailable![i % 7] = false
            task1.id = UUID()
            task1.goal = goal
            task1.image = allIcons[i].pngData() as NSData?
            tasks.append(task1)
        }
        //.............
        // END COMMENT OUT TEST
        
        
        for task in tasks {
            if isTaskToday(task: task) && !task.isComplete {
                todayTasks.append(task)
            }
        }
        
        self.collectionView.reloadData()
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longTap(_:)))
        
        collectionView.addGestureRecognizer(longPressGesture)
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert]) {
            (granted, error) in
            if granted {
                print("yes")
            } else {
                print("No")
            }
        }
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        switch segue.identifier {
        case "switchToGoals":
            _ = segue.destination as! GoalTestViewController
        case "focusOnTask":
            let selectedTaskCell = sender as! TaskCell
            let focusVC = segue.destination as! FocusViewController
            focusVC.taskID = selectedTaskCell.id
        case "todaySettings":
            _ = segue.destination as! SettingsTestViewController
        default:
            fatalError()
        }
    }
    
    
    // MARK: - Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todayTasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "taskCell", for: indexPath) as! TaskCell
        
        cell.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.4352941176, blue: 0.3176470588, alpha: 1)
        
        cell.configure(with: todayTasks[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let sideSpacing = layout.minimumInteritemSpacing + layout.sectionInset.left + layout.sectionInset.right
        let size = (self.view.frame.width - sideSpacing - 40) / 2
        return CGSize(width: size, height: size * cellAspect)
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp = todayTasks.remove(at: sourceIndexPath.item)
        todayTasks.insert(temp, at: destinationIndexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @objc func longTap(_ gesture: UIGestureRecognizer){
        
        guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
            return
        }
        let cell = collectionView.cellForItem(at: selectedIndexPath) as! TaskCell
        
        switch(gesture.state) {
        case .began:
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
            cell.startAnimate()
            
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case .ended:
            collectionView.endInteractiveMovement()
            cell.stopAnimate()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    
    @IBAction func toggleSort(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            sortTasksByDeadline()
        case 1:
            sortTasksByPriority()
        default:
            fatalError()
        }
        
    }

    // Mark: - Private Functions
    
    private func isTaskToday(task: Task) -> Bool {
        
        if let daysScheduled = task.daysAvailable {
            
            let today = Calendar.current.component(.weekday, from: Date())
            return daysScheduled[today-1]
            
        }
        return false
    }
    
    private func sortTasksByDeadline () {
        
        let tempTasks = todayTasks.enumerated().sorted { (task1, task2) -> Bool in
            task1.element.deadline!.timeIntervalSince(task2.element.deadline! as Date) > 0
        }

        batchSort(tempTasks: tempTasks)
        print("Deadline")
        
    }
    
    private func sortTasksByPriority () {

        let tempTasks = todayTasks.enumerated().sorted { (task1, task2) -> Bool in
            task1.element.priority > task2.element.priority
        }

        batchSort(tempTasks: tempTasks)
        print("Priority")
        
    }
    
    // MARK: - Animations
    
    private func batchUpdate(index: Int) {
        
        if index*2 < todayTasks.count  {
            collectionView.performBatchUpdates(
                {
                    collectionView.deleteItems(at: [IndexPath(row: index*2, section: 0)])
                    collectionView.insertItems(at: [IndexPath(row: index*2, section: 0)])
                    
                    if index*2+1 < todayTasks.count {
                        collectionView.deleteItems(at: [IndexPath(row: index*2+1, section: 0)])
                        collectionView.insertItems(at: [IndexPath(row: index*2+1, section: 0)])
                    }
                    
            }, completion: { (finished:Bool) -> Void in
                self.batchUpdate(index: index + 1)
            })
        }
    }
    
    private func batchSort (tempTasks: [(offset: Int, element: Task)]) {
        
        let afterIndices = tempTasks.map{$0.offset}
        print(afterIndices)
        todayTasks = tempTasks.map{$0.element}
        
        // perform animation with one row at a time
        batchUpdate(index: 0)
        
        //perform all at once - all sliding up together
//        collectionView.performBatchUpdates(
//        {
//            for i in 0..<todayTasks.count {
//                collectionView.deleteItems(at: [IndexPath(row: i, section: 0)])
//                collectionView.insertItems(at: [IndexPath(row: i, section: 0)])
//            }
//        }, completion: { (finished:Bool) -> Void in
//        })
        
    }
    
}

