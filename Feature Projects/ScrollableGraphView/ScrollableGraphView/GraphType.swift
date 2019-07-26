//
//  GraphType.swift
//  ScrollableGraphView
//
//  Created by Cameron Mcleod on 2019-07-24.
//  Copyright © 2019 Cameron Mcleod. All rights reserved.
//

// The type of the current graph we are showing.
enum GraphType {
    case multiTwo
    case bar
    
    mutating func next() {
        switch(self) {
        case .multiTwo:
            self = GraphType.bar
        case .bar:
            self = GraphType.multiTwo
        }
    }
}
