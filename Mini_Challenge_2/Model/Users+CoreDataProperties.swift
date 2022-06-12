//
//  Users+CoreDataProperties.swift
//  Mini_Challenge_2
//
//  Created by feedloop on 12/06/22.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var restaurants: NSSet?

}

// MARK: Generated accessors for restaurants
extension Users {

    @objc(addRestaurantsObject:)
    @NSManaged public func addToRestaurants(_ value: Restaurants)

    @objc(removeRestaurantsObject:)
    @NSManaged public func removeFromRestaurants(_ value: Restaurants)

    @objc(addRestaurants:)
    @NSManaged public func addToRestaurants(_ values: NSSet)

    @objc(removeRestaurants:)
    @NSManaged public func removeFromRestaurants(_ values: NSSet)

}

extension Users : Identifiable {

}
