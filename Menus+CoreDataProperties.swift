//
//  Menus+CoreDataProperties.swift
//  Mini_Challenge_2
//
//  Created by feedloop on 12/06/22.
//
//

import Foundation
import CoreData


extension Menus {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Menus> {
        return NSFetchRequest<Menus>(entityName: "Menus")
    }

    @NSManaged public var name: String?
    @NSManaged public var restaurant: String?
    @NSManaged public var imageUrl: String?

}

extension Menus : Identifiable {

}
