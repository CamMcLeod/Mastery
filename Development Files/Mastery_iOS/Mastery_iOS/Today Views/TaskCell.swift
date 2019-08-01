//
//  TaskCell.swift
//  Mastery_iOS
//
//  Created by Cameron Mcleod on 2019-07-27.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class TaskCell: UICollectionViewCell {
    
    var isAnimate: Bool! = true
    var id: UUID?
    
    @IBOutlet weak var taskView: TaskIconWithLabel!
    
    
    public func configure(with task: Task) {
        
        let iconImage = UIImage(data: task.image! as Data)!
        let color = task.goal!.color!
        taskView.setupWithRaw(name: task.name!, newImage: iconImage, goalColor: color)
        id = task.id
    }
    
    //Animation of image
    func startAnimate() {
        taskView.taskIcon.animate()
    }
    
}
