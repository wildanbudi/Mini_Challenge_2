//
//  Reviews+CoreDataProperties.swift
//  Vegcation
//
//  Created by Wildan Budi on 03/07/22.
//
//

import Foundation
import CoreData


extension Reviews {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reviews> {
        return NSFetchRequest<Reviews>(entityName: "Reviews")
    }

    @NSManaged public var comment: String?
    @NSManaged public var date: Date?
    @NSManaged public var image: Data?
    @NSManaged public var rate: Int16
    @NSManaged public var restaurant: Restaurants?
    @NSManaged public var user: Users?

}

extension Reviews : Identifiable {

}
