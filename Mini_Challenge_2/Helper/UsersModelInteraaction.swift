//
//  UsersModelInteraaction.swift
//  Mini_Challenge_2
//
//  Created by feedloop on 26/06/22.
//

import Foundation
import UIKit

class UsersModel {
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func getUser() -> Users {
        do {
            let users = try context.fetch(Users.fetchRequest())
            let currentUser = users.filter({(r: Users) -> Bool in
                return r.name == "Vegeta Doe"
            }).first ?? Users(context: context)
        
            return currentUser
        } catch _ {
            return Users(context: context)
        }
    }
}
