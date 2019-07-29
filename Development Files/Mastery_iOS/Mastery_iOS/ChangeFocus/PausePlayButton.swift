//
//  PausePlayButton.swift
//  Mastery_iOS
//
//  Created by Cameron Mcleod on 2019-07-28.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit

class PausePlayButton: UIButton {
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    func animatePlayPause() {
        
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = 0.1
        pulseAnimation.repeatCount = 2
        
        let startScale: Float = 0.80
        let stopScale: Float = 1.2
        
        pulseAnimation.fromValue = NSNumber(value: startScale as Float)
        pulseAnimation.toValue = NSNumber(value: stopScale as Float)
        pulseAnimation.autoreverses = true
        pulseAnimation.timeOffset = 290 * drand48()
        
        let layer: CALayer = self.layer
        layer.add(pulseAnimation, forKey:"animatePlayPause")
    }
}
