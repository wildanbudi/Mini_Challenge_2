//
//  Reviews+CoreDataProperties.swift
//  Mini_Challenge_2
//
//  Created by feedloop on 22/06/22.
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
    @NSManaged public var rate: Int16
    @NSManaged public var image: Data?
    @NSManaged public var restaurant: Restaurants?
    @NSManaged public var user: Users?

}

extension Reviews : Identifiable {

}
