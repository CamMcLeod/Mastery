//
//  Goal+CoreDataProperties.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-25.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//
//

import Foundation
import CoreData


extension Goal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: "Goal")
    }

    @NSManaged public var dateOfBirth: NSDate?
    @NSManaged public var deadline: [Date]?
    @NSManaged public var id: UUID?
    @NSManaged public var image: NSData?
    @NSManaged public var isComplete: Bool
    @NSManaged public var name: String?
    @NSManaged public var opened: Bool
    @NSManaged public var purpose: String?
    @NSManaged public var user: User?
    @NSManaged public var tasks: NSSet?

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
