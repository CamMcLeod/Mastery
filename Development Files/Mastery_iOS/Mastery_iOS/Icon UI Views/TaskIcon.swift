//
//  taskIconView.swift
//  Mastery_iOS
//
//  Created by Marina Mona June McPeak on 2019-07-27.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class TaskIcon : UIView, UIGestureRecognizerDelegate{
    
    let kCONTENT_XIB_NAME = "TaskIcon"
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var taskRing: UIImageView!
    @IBOutlet weak var iconImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
        let tapWiggleGesture = UITapGestureRecognizer(target: self, action: #selector(animate))
        tapWiggleGesture.numberOfTapsRequired = 2
        self.addGestureRecognizer(tapWiggleGesture)
    }
    
    func iconSetup(icon : UIImage?, iconColor : UIColor) {
        
        let tintedRing = taskRing.image?.withRenderingMode(.alwaysTemplate)
        taskRing.image = tintedRing
        taskRing.tintColor = iconColor
        
        let tintedImage = icon?.withRenderingMode(.alwaysTemplate)
        iconImage.image = tintedImage
        iconImage.tintColor = iconColor
    }
    
    @objc func animate() {
        
        let pulseAnimation = animateAttributes(keyPath: "transform.scale")
        let spinAnimation = animateAttributes(keyPath: "opacity")
        
        let ringLayer: CALayer = taskRing.layer
        let iconLayer: CALayer = iconImage.layer
        ringLayer.add(pulseAnimation, forKey:"animatePlayPause")
        iconLayer.add(spinAnimation, forKey:"animatePlayPause")
    }
    
    func animateAttributes(keyPath: String) -> CABasicAnimation {
        
        let pulseAnimation = CABasicAnimation(keyPath: keyPath)
        
        pulseAnimation.duration = 0.1
        pulseAnimation.repeatCount = 2
        
        let startScale: Float = 1.0
        let stopScale: Float = 0.8
        
        pulseAnimation.fromValue = NSNumber(value: startScale as Float)
        pulseAnimation.toValue = NSNumber(value: stopScale as Float)
        pulseAnimation.autoreverses = true
        return pulseAnimation
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
