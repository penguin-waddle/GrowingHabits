//
//  Plant+CoreDataProperties.swift
//  GrowingHabits
//
//  Created by Vivien on 7/19/23.
//
//

import Foundation
import CoreData


extension Plant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Plant> {
        return NSFetchRequest<Plant>(entityName: "Plant")
    }

    @NSManaged public var importance: Int32
    @NSManaged public var avatar: String?
    @NSManaged public var lastWateredDate: Date?
    @NSManaged public var wateringFrequency: Int32
    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var user: User?

}

extension Plant : Identifiable {

}
