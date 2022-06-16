//
//  Menus+CoreDataProperties.swift
//  Mini_Challenge_2
//
//  Created by feedloop on 16/06/22.
//
//

import Foundation
import CoreData


extension Menus {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Menus> {
        return NSFetchRequest<Menus>(entityName: "Menus")
    }

    @NSManaged public var imageUrl: String?
    @NSManaged public var name: String?
    @NSManaged public var image: Data?
    @NSManaged public var restaurant: Restaurants?

}

extension Menus : Identifiable {

}
