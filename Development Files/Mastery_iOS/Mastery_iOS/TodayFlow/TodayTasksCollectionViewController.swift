//
//  TodayTasksCollectionViewController.swift
//  Mastery_iOS
//
//  Created by Cameron Mcleod on 2019-07-25.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "iconCell"

class TodayTasksCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var tasks = [Task]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        do {
            let tasks =  try PersistenceService.context.fetch(fetchRequest)
            
            if tasks.count == 0 {
                print("no items returned")
            }
            for task in tasks {
                
                if isTaskToday(task: task) {
                    self.tasks.append(task)
                }
                
            }
            
        } catch {
            print("Oh no, there is no data to load")
        }
        let task1 = Task(context: PersistenceService.context)
        task1.image = UIImage(named: "falcon")?.pngData() as NSData?
        task1.name = "Be Cool"
        tasks.append(task1)
        self.collectionView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return tasks.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! IconCollectionViewCell
        
        let task = tasks[indexPath.row]
        if let imageData = task.image as Data? {
            if let image = UIImage(data: imageData) {
                cell.imageView.image = image
            } else {
                cell.imageView.image = UIImage(named: "falcon")
            }
        }
        
        cell.name.text = task.name
        
    
        return cell
    }
    
    private func isTaskToday(task: Task) -> Bool {
        
        if let taskDate = task.dateOfBirth! as Date? {
            let today = Date()
            let diff = Calendar.current.dateComponents([.day], from: taskDate, to: today)
            if diff.day == 0 {
                return true
            } else {
                return false
            }
        }
        
        return false

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (self.view.frame.width - 20) / 2
        return CGSize(width: size, height: size)
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
