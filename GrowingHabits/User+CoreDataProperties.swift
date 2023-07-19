//
//  User+CoreDataProperties.swift
//  GrowingHabits
//
//  Created by Vivien on 7/19/23.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var username: String?
    @NSManaged public var id: UUID?
    @NSManaged public var plants: NSSet?

}

// MARK: Generated accessors for plants
extension User {

    @objc(addPlantsObject:)
    @NSManaged public func addToPlants(_ value: Plant)

    @objc(removePlantsObject:)
    @NSManaged public func removeFromPlants(_ value: Plant)

    @objc(addPlants:)
    @NSManaged public func addToPlants(_ values: NSSet)

    @objc(removePlants:)
    @NSManaged public func removeFromPlants(_ values: NSSet)

}

extension User : Identifiable {

}
