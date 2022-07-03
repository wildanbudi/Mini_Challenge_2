//
//  Menus+CoreDataProperties.swift
//  Vegcation
//
//  Created by Wildan Budi on 03/07/22.
//
//

import Foundation
import CoreData


extension Menus {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Menus> {
        return NSFetchRequest<Menus>(entityName: "Menus")
    }

    @NSManaged public var image: Data?
    @NSManaged public var imageUrl: String?
    @NSManaged public var name: String?
    @NSManaged public var restaurant: Restaurants?

}

extension Menus : Identifiable {

}
