//
//  Restaurants+CoreDataProperties.swift
//  Mini_Challenge_2
//
//  Created by feedloop on 16/06/22.
//
//

import Foundation
import CoreData


extension Restaurants {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Restaurants> {
        return NSFetchRequest<Restaurants>(entityName: "Restaurants")
    }

    @NSManaged public var address: String?
    @NSManaged public var city: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var kecamatan: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var name: String?
    @NSManaged public var openHours: String?
    @NSManaged public var phone: String?
    @NSManaged public var priceMax: String?
    @NSManaged public var priceMin: String?
    @NSManaged public var rating: Double
    @NSManaged public var vegeResto: Bool
    @NSManaged public var image: Data?
    @NSManaged public var menus: NSSet?
    @NSManaged public var users: NSSet?

}

// MARK: Generated accessors for menus
extension Restaurants {

    @objc(addMenusObject:)
    @NSManaged public func addToMenus(_ value: Menus)

    @objc(removeMenusObject:)
    @NSManaged public func removeFromMenus(_ value: Menus)

    @objc(addMenus:)
    @NSManaged public func addToMenus(_ values: NSSet)

    @objc(removeMenus:)
    @NSManaged public func removeFromMenus(_ values: NSSet)

}

// MARK: Generated accessors for users
extension Restaurants {

    @objc(addUsersObject:)
    @NSManaged public func addToUsers(_ value: Users)

    @objc(removeUsersObject:)
    @NSManaged public func removeFromUsers(_ value: Users)

    @objc(addUsers:)
    @NSManaged public func addToUsers(_ values: NSSet)

    @objc(removeUsers:)
    @NSManaged public func removeFromUsers(_ values: NSSet)

}

extension Restaurants : Identifiable {

}
