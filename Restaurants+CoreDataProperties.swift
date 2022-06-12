//
//  Restaurants+CoreDataProperties.swift
//  Mini_Challenge_2
//
//  Created by feedloop on 12/06/22.
//
//

import Foundation
import CoreData


extension Restaurants {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Restaurants> {
        return NSFetchRequest<Restaurants>(entityName: "Restaurants")
    }

    @NSManaged public var address: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var name: String?
    @NSManaged public var openHours: String?
    @NSManaged public var phone: String?
    @NSManaged public var priceMax: String?
    @NSManaged public var priceMin: String?
    @NSManaged public var rating: Double
    @NSManaged public var imageUrl: String?
    @NSManaged public var vegeResto: Bool

}

extension Restaurants : Identifiable {

}
