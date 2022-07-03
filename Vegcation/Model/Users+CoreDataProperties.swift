//
//  Users+CoreDataProperties.swift
//  Vegcation
//
//  Created by Wildan Budi on 03/07/22.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var email: String?
    @NSManaged public var image: Data?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var restaurants: NSSet?
    @NSManaged public var reviews: NSSet?

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

// MARK: Generated accessors for reviews
extension Users {

    @objc(addReviewsObject:)
    @NSManaged public func addToReviews(_ value: Reviews)

    @objc(removeReviewsObject:)
    @NSManaged public func removeFromReviews(_ value: Reviews)

    @objc(addReviews:)
    @NSManaged public func addToReviews(_ values: NSSet)

    @objc(removeReviews:)
    @NSManaged public func removeFromReviews(_ values: NSSet)

}

extension Users : Identifiable {

}
