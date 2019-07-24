//
//  Goal+CoreDataProperties.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-24.
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
    @NSManaged public var isComplete: Bool
    @NSManaged public var name: String?
    @NSManaged public var purpose: String?
    @NSManaged public var image: NSData?
    @NSManaged public var opened: Bool
    @NSManaged public var user: User?
    @NSManaged public var plans: NSSet?

}

// MARK: Generated accessors for plans
extension Goal {

    @objc(addPlansObject:)
    @NSManaged public func addToPlans(_ value: Plan)

    @objc(removePlansObject:)
    @NSManaged public func removeFromPlans(_ value: Plan)

    @objc(addPlans:)
    @NSManaged public func addToPlans(_ values: NSSet)

    @objc(removePlans:)
    @NSManaged public func removeFromPlans(_ values: NSSet)

}
