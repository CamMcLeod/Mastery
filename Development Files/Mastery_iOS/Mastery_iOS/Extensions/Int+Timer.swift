//
//  Int+Timer.swift
//  
//
//  Created by Cameron Mcleod on 2019-07-29.
//

import Foundation

extension Int {
    
    func secondsToMinutesSeconds() -> String {
        let (m,s) = (self / 60, self % 60)
        return String(format: "%02d:%02d", m,s)
    }
    
}
