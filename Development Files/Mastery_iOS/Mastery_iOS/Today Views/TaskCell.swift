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
        
        
        taskView.setupWithRaw(name: task.name!, newImage: UIImage(data: task.image! as Data)!, goalColor: task.goal!.color!)
    }
    
    //Animation of image
    func startAnimate() {
        let shakeAnimation = CABasicAnimation(keyPath: "transform.rotation")
        shakeAnimation.duration = 0.1
        shakeAnimation.repeatCount = 99999
        
        let startAngle: Float = (-1) * 3.14159/180
        let stopAngle = -startAngle
        
        shakeAnimation.fromValue = NSNumber(value: startAngle as Float)
        shakeAnimation.toValue = NSNumber(value: 3 * stopAngle as Float)
        shakeAnimation.autoreverses = true
        shakeAnimation.timeOffset = 290 * drand48()
        
        let layer: CALayer = self.layer
        layer.add(shakeAnimation, forKey:"animate")
        isAnimate = true
    }
    
    func stopAnimate() {
        let layer: CALayer = self.layer
        layer.removeAnimation(forKey: "animate")
        isAnimate = false
    }
}
