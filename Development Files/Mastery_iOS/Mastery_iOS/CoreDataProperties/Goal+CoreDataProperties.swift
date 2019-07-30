//
//  Goal+CoreDataProperties.swift
//  Mastery_iOS
//
//  Created by Cameron Mcleod on 2019-07-29.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit


extension Goal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: "Goal")
    }
 
    @NSManaged public var color: UIColor?
    @NSManaged public var dateOfBirth: NSDate?
    @NSManaged public var deadline: [Date]?
    @NSManaged public var goalDescription: String?
    @NSManaged public var hoursCompleted: Float
    @NSManaged public var hoursEstimate: Float
    @NSManaged public var id: UUID?
    @NSManaged public var isComplete: Bool
    @NSManaged public var name: String?
    @NSManaged public var priority: Int16
    @NSManaged public var tags: [String]?
    @NSManaged public var tasks: NSSet?
    @NSManaged public var user: User?

}

// MARK: Generated accessors for tasks
extension Goal {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: Task)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: Task)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}
