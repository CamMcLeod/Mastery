//
//  Int+Timer.swift
//  
//
//  Created by Cameron Mcleod on 2019-07-29.
//

import Foundation

public extension Int {
    
    func secondsToHoursMinutesSeconds() -> String {
        if self > 3599 {
            let (h,m,s) = (self / 3600,(self / 60) % 60, self % 60)
            return String(format: "%01d:%02d:%02d",h, m,s)
        } else {
            let (m,s) = ((self / 60) % 60, self % 60)
            return String(format: "%02d:%02d", m,s)
        }

    }
    
}
