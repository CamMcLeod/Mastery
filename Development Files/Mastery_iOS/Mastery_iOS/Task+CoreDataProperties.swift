//
//  Task+CoreDataProperties.swift
//  Mastery_iOS
//
//  Created by Ekam Singh Dhaliwal on 2019-07-24.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//
//

import Foundation
import CoreData
import CoreLocation


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var completionDate: NSDate?
    @NSManaged public var dateOfActivity: NSDate?
    @NSManaged public var dateOfBirth: NSDate?
    @NSManaged public var deadline: NSDate?
    @NSManaged public var id: UUID?
    @NSManaged public var isComplete: Bool
    @NSManaged public var lengthOfActivity: Float
    @NSManaged public var location: CLLocation?
    @NSManaged public var name: String?
    @NSManaged public var preRequisiteTasks: [UUID]?
    @NSManaged public var priority: String?
    @NSManaged public var taskDescription: String?
    @NSManaged public var timeEstimate: Float
    @NSManaged public var image: NSData?
    @NSManaged public var plan: Plan?

}
