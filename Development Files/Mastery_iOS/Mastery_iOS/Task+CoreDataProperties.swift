//
//  Task+CoreDataProperties.swift
//  Mastery_iOS
//
//  Created by Cameron Mcleod on 2019-07-26.
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
    @NSManaged public var taskDatesAndDurations: [Date : Float]?
    @NSManaged public var dateOfBirth: NSDate?
    @NSManaged public var deadline: NSDate?
    @NSManaged public var id: UUID?
    @NSManaged public var image: NSData?
    @NSManaged public var isComplete: Bool
    @NSManaged public var location: CLLocation?
    @NSManaged public var name: String?
    @NSManaged public var preRequisiteTasks: [UUID]?
    @NSManaged public var priority: Int16
    @NSManaged public var taskDescription: String?
    @NSManaged public var timeEstimate: Float
    @NSManaged public var tags: [String]?
    @NSManaged public var notes: [String]?
    @NSManaged public var goal: Goal?

}
