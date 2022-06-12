//
//  Favorites+CoreDataProperties.swift
//  Mini_Challenge_2
//
//  Created by feedloop on 12/06/22.
//
//

import Foundation
import CoreData


extension Favorites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorites> {
        return NSFetchRequest<Favorites>(entityName: "Favorites")
    }


}

extension Favorites : Identifiable {

}
