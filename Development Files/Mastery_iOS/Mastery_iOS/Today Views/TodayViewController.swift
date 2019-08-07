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

private let cellAspect = 1.25 as CGFloat

class TodayViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate{
    
    var tasks = [Task]()
    var todayTasks = [Task]()
    var allIcons: [UIImage] = []
    var allNames: [String] = []
    
    
    var colorArray: [UIColor] = [UIColor(red:0.49, green:0.47, blue:0.73, alpha:1.0),
                                 UIColor(red:0.91, green:0.44, blue:0.32, alpha:1.0),
                                 UIColor(red:0.35, green:0.76, blue:0.76, alpha:1.0),
                                 UIColor(red:0.55, green:0.70, blue:0.41, alpha:1.0),
                                 UIColor(red:0.96, green:0.74, blue:0.38, alpha:1.0)]
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var switchToGoalsButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var sortByControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        // Do any additional setup after loading the view.
        
    
        
        // UNCOMMENT TO UNLEASH FURY
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        
        do {
            let tasks =  try PersistenceService.context.fetch(fetchRequest)
            self.tasks = tasks
            print(tasks.count)
            if tasks.count == 0 {
                loadDummyData()
                let fetchRequest2 = NSFetchRequest<Task>(entityName: "Task")
                let tasks =  try PersistenceService.context.fetch(fetchRequest2)
                self.tasks = tasks
                print(tasks.count)
            }
        } catch {
            print("Oh no, there is no data to load")
        }
        
        collectionView.layer.borderWidth = 5
        collectionView.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        collectionView.layer.cornerRadius = 15.0
        
        
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
            break
        case "focusOnTask":
            let selectedTaskCell = sender as! TaskCell
            let focusVC = segue.destination as! FocusViewController
            focusVC.taskID = selectedTaskCell.id
            focusVC.goalColor = selectedTaskCell.taskView.taskIcon.tintColor
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
        
        cell.configure(with: todayTasks[indexPath.row])
            switch self.sortByControl.selectedSegmentIndex {
                case 0:
                    
                let thisTask = self.todayTasks[indexPath.row]
                let totalTime = (thisTask.deadline?.timeIntervalSince(thisTask.dateOfBirth! as Date))!
                let timePassed = Date().timeIntervalSince(thisTask.dateOfBirth! as Date)
                cell.taskView.taskIcon.redrawRingCollection(completion: CGFloat(timePassed/totalTime))
                print(timePassed/totalTime)
                case 1:
                    
                let thisTask = self.todayTasks[indexPath.row]
                let priorityRatio = CGFloat(CGFloat(thisTask.priority) / 10)
                cell.taskView.taskIcon.drawRingFillCollection(completion: priorityRatio)
                
                default:
                fatalError()
            }
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
            cell.startAnimate()
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
            task1.element.deadline!.timeIntervalSince(task2.element.deadline! as Date) < 0
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
                if self.collectionView.indexPathsForVisibleItems.contains(IndexPath(row: index*2, section: 0))  {
                    let rowIndex = index*2
                    let indexPath = IndexPath(row: rowIndex, section: 0)
                    let cell = self.collectionView.cellForItem(at: indexPath) as! TaskCell
                    cell.startAnimate()
                    
                }
                if self.collectionView.indexPathsForVisibleItems.contains(IndexPath(row: index*2+1, section: 0))  {
                    let rowIndex = index*2+1
                    let indexPath = IndexPath(row: rowIndex, section: 0)
                    let cell = self.collectionView.cellForItem(at: indexPath) as! TaskCell
                    cell.startAnimate()
                    
                }
                
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
        
    }
    
    func loadDummyData() {
        
        guard let bundleURL = Bundle.main.url(forResource: "TaskIcons", withExtension: "bundle") else { return }
        guard let bundle = Bundle(url: bundleURL) else { return }
        guard let imageURLs = bundle.urls(forResourcesWithExtension: ".png", subdirectory: nil) else { return }
        
        for imageURL in imageURLs {
            guard let image = UIImage(contentsOfFile: imageURL.path) else { continue }
            allIcons.append(image)
            var componentString = imageURL.lastPathComponent
            componentString.remove(at: componentString.index(before: componentString.endIndex))
            componentString.remove(at: componentString.index(before: componentString.endIndex))
            componentString.remove(at: componentString.index(before: componentString.endIndex))
            componentString.remove(at: componentString.index(before: componentString.endIndex))
            allNames.append(componentString)
            
        }
        
        var testGoals = [Goal]()
        for i in 1...5 {
            let goal = getgoal(i: i)
            testGoals.append(goal)
        }

        
        
        for i in 1...6 {
            
            let task1 = Task(context: PersistenceService.context)
            task1.name = allNames[i]
            task1.dateOfBirth = NSDate(timeIntervalSinceNow: -500000)
            task1.isComplete = i % 2 == 0 ? true : false
            task1.daysAvailable = Array.init(repeating: true, count: 7)
            task1.deadline = NSDate(timeIntervalSinceNow: 10000 * Double(i))
            task1.priority = Int16(arc4random_uniform(10)+1)
            task1.daysAvailable![i % 7] = false
            task1.timeEstimate = 1000
            task1.tags = ["woof", "hello"]
            task1.id = UUID()
            let val = i % 5
            switch val {
            case 0:
                task1.goal = testGoals[val]
                testGoals[val].addToTasks(task1)
            case 1:
                task1.goal = testGoals[val]
                testGoals[val].addToTasks(task1)
            case 2:
                task1.goal = testGoals[val]
                testGoals[val].addToTasks(task1)
            case 3:
                task1.goal = testGoals[val]
                testGoals[val].addToTasks(task1)
            case 4:
                task1.goal = testGoals[val]
                testGoals[val].addToTasks(task1)
            default:
                return
            }
            
            task1.image = allIcons[i].pngData() as NSData?
            PersistenceService.saveContext()
        
        }
    }
    
    func getgoal (i: Int) -> Goal {
        
        let goal = Goal(context: PersistenceService.context)
        goal.id = UUID()
        goal.name = allNames[i-1]
        goal.goalDescription = "do it!"
        goal.isComplete = false
        goal.hoursEstimate = 500 * Float(i)
        goal.hoursCompleted = 0.0
        goal.priority = 2
        goal.dateOfBirth = Date() as NSDate
        goal.deadline = [Date(timeIntervalSinceNow: 50000 * Double(i))]
        goal.color = colorArray[i-1]
        goal.tags = ["stinky", "woof"]
        PersistenceService.saveContext()
        
        return goal
    }
    
//    switch self.sortByControl.selectedSegmentIndex {
//    case 0:
//    let thisTask = self.todayTasks[indexPath.row]
//    let totalTime = (thisTask.deadline?.timeIntervalSince(thisTask.dateOfBirth! as Date))!
//    let timePassed = Date().timeIntervalSince(thisTask.dateOfBirth! as Date)
//    cell.taskView.taskIcon.redrawRing(completion: CGFloat(timePassed/totalTime))
//    case 1:
//    let thisTask = self.todayTasks[indexPath.row]
//    let priorityRatio = CGFloat(thisTask.priority / 10)
//    cell.taskView.taskIcon.drawRingFill(completion: priorityRatio)
//    default:
//    fatalError()
//    }
}

