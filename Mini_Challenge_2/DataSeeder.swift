//
//  DataSeeder.swift
//  Mini_Challenge_2
//
//  Created by feedloop on 12/06/22.
//

import Foundation
import CoreData

public class DataHelper {
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    public func seedDataStore() {
        seedRestaurants()
        seedMenus()
        seedUsers()
    }
    
    fileprivate func seedRestaurants() {
        let restaurants = [
            (name: "Resto Indo Vegan", rating: 4.5, openHours: "07:00 - 18:00", phone: "0811953539", priceMin: "10000", priceMax: "60000", address: "Jalan Duri Selatan 1 No. 9, RT.06/ RW.02, RT.6/RW.2, Duri Sel., Kec. Tambora, Kota Jakarta Barat, Daerah Khusus Ibukota Jakarta 11270", imageUrl: "https://drive.google.com/uc?id=1eQa7DP1a1fC9gkjBvg24XJSaJkEDeUFW", latitude: 0.0, longitude: 0.0, vegeResto: true),
            (name: "Dharma Kitchen", rating: 4.5, openHours: "10:00 - 21:00", phone: "0216618302", priceMin: "75000", priceMax: "200000", address: "Jl. Pluit Kencana Raya No.124, RT.10/RW.7, Pluit, Kec. Penjaringan, Kota Jkt Utara, Daerah Khusus Ibukota Jakarta 14450", imageUrl: "https://drive.google.com/uc?id=1mpJh9v98tJeahcZIFpsZNPlxZkyxEn2q", latitude: 0.0, longitude: 0.0, vegeResto: true),
            (name: "Grassland Vegetarian Restaurant", rating: 4.5, openHours: "10:00 - 21:00", phone: "02129414533", priceMin: "10000", priceMax: "50000", address: "Jl. Hadiah 1 No.1564A, RT.7/RW.2, Jelambar, Kec. Grogol petamburan, Kota Jakarta", imageUrl: "https://drive.google.com/uc?id=1gboIULBnm7PdwGKYIRan75D5pK2e-6eG", latitude: 0.0, longitude: 0.0, vegeResto: true),
            (name: "Vegetus Vegetarian", rating: 4.5, openHours: "09:00 - 22:00", phone: "083876501618", priceMin: "50000", priceMax: "200000", address: "Jl. Pluit Karang Timur, Blok O-8 Timur No.38-39, RT.5/RW.14, Pluit, Penjaringan, RT.5/RW.14, Pluit, Kec. Penjaringan, Kota Jkt Utara, Daerah Khusus Ibukota Jakarta 14450", imageUrl: "https://drive.google.com/uc?id=1V9n_XKuDsbUtTNaDQWfVRvTvmt--bCm_", latitude: 0.0, longitude: 0.0, vegeResto: true),
            (name: "Che En Vegetarian", rating: 4.5, openHours: "07:00 - 19:00", phone: "0216413523", priceMin: "5000", priceMax: "100000", address: "Gg. 22 No.11 B, RT.1/RW.1, Pademangan Tim., Kec. Pademangan, Kota Jkt Utara, Daerah Khusus Ibukota Jakarta 14410", imageUrl: "https://drive.google.com/uc?id=1DM9PYHzJTAyc3zT-p59JxVW94SklNU3l", latitude: 0.0, longitude: 0.0, vegeResto: true),
            (name: "Starbucks", rating: 4.6, openHours: "06:00 - 22:00", phone: "02139833377", priceMin: "20000", priceMax: "60000", address: "Jl. M.H. Thamrin No.9, RW.1, Kb. Sirih, Kec. Menteng, Kota Jakarta Pusat, Daerah Khusus Ibukota Jakarta 10340", imageUrl: "", latitude: 0.0, longitude: 0.0, vegeResto: false),
            (name: "Kayu-Kayu Restaurant", rating: 4.0, openHours: "10:00 - 22:00", phone: "081318002828", priceMin: "10000", priceMax: "350000", address: "Jl. Jalur Sutera No.28A, Pakualam, Kec. Serpong Utara, Kota Tangerang Selatan, Banten 15325", imageUrl: "https://drive.google.com/uc?id=1z1i63WVWTdCjc3m3gjYRFEMoM_gEwvtX", latitude: 0.0, longitude: 0.0, vegeResto: false),
            (name: "Taman Santap Rumah Kayu", rating: 4.5, openHours: "10:00 - 22:00", phone: "02154212011", priceMin: "15000", priceMax: "300000", address: "Jl. Ki Hajar Dewantara SKL No. 002, Pakulonan Bar., Kec. Klp. Dua, Kabupaten Tangerang, Banten 15810", imageUrl: "https://drive.google.com/uc?id=1CFRtD39_ZJbvZD9w7kGN2zV71Unl3EWB", latitude: 0.0, longitude: 0.0, vegeResto: false),
            (name: "Fromaggio Coffee and Resto", rating: 4.5, openHours: "10:00 - 22:00", phone: "02155783238", priceMin: "20000", priceMax: "60000", address: "Jl. Nyimas Melati No.A2, RT.2/RW.1, Sukarasa, Kec. Tangerang, Kota Tangerang, Banten 15111", imageUrl: "https://drive.google.com/uc?id=1RuwaZ1ITF6XACBQZPu6w5ACW4bgAknXr", latitude: 0.0, longitude: 0.0, vegeResto: false),
        ]
        
        for restaurant in restaurants {
            let newRestaurant = NSEntityDescription.insertNewObject(forEntityName: "Restaurants", into: context) as! Restaurants
            newRestaurant.name = restaurant.name
            newRestaurant.rating = restaurant.rating
            newRestaurant.openHours = restaurant.openHours
            newRestaurant.phone = restaurant.phone
            newRestaurant.priceMin = restaurant.priceMin
            newRestaurant.priceMax = restaurant.priceMax
            newRestaurant.address = restaurant.address
            newRestaurant.imageUrl = restaurant.imageUrl
            newRestaurant.latitude = restaurant.latitude
            newRestaurant.longitude = restaurant.longitude
        }
        
        do {
            try context.save()
        } catch _ {
        }
    }
    
    fileprivate func seedMenus() {
        let menus = [
            (name: "Asinan Bogor", imageUrl: "https://drive.google.com/uc?id=1hyS-ryw5HWKLMd8cu3bnTgJ5Qf_sYDsk"),
            (name: "Breakfast Set", imageUrl: "https://drive.google.com/uc?id=1ksVZMsY4dgTeULiS4E9hOkkJhfA6rrxF"),
            (name: "Enoki Jamur Goreng", imageUrl: "https://drive.google.com/uc?id=1gjMRAeTE9vyN0LARtQYvRQSpJVUpMDp9"),
            (name: "Martabak Vegie", imageUrl: "https://drive.google.com/uc?id=1uLf4UoC8xXfGqdNV3tmbschtXgbO8Vxr"),
            (name: "Terong Balado", imageUrl: "https://drive.google.com/uc?id=1AbD2scdC09SqZEJ0p4Vk-JTKP-dLjI17"),
            (name: "Kangkung Balacan", imageUrl: "https://drive.google.com/uc?id=1EKxqW3_1hwA4oDCmxkp61bSEQvmh5zvd"),
            (name: "Kangkung Cah Jamur", imageUrl: "https://drive.google.com/uc?id=1KDK3FIh6FEaZ5bbg8i9aOjWCgDG0xciE"),
            (name: "Kangkung Plecing", imageUrl: "https://drive.google.com/uc?id=1GkYCFpAcrMWdOPKYLrj8QKhOD-qJPWlU"),
            (name: "Tauge Cah Polos", imageUrl: "https://drive.google.com/uc?id=1KDQhFIjsduPMmSMgjsB8Cqs9KYGhdCkN"),
            (name: "Terong Goreng", imageUrl: "https://drive.google.com/uc?id=1uoQw5Xm-kYaqHkVL5WXFRCCoSIMNupok"),
            (name: "Caesar Salad", imageUrl: "https://drive.google.com/uc?id=1GeKCLu5GfA_PUnu-SsU02vdCvnKzgZs8"),
            (name: "Corn and Carrot Soup", imageUrl: "https://drive.google.com/uc?id=13J1iIg-THOaMO2oUZk8PDLdYKrCF_qZi"),
            (name: "Mushroom Cream Soup", imageUrl: "https://drive.google.com/uc?id=1fwP0k1jSZMyd55uOKZC_jaLQJ2Zc_BLf"),
            (name: "Nacos Con Fungi", imageUrl: "https://drive.google.com/uc?id=1A9Uc_0H8KsQZcGGSvYxCMUYhQ2KrTvW8"),
            (name: "Pad Thai", imageUrl: "https://drive.google.com/uc?id=1JiPQbnR--XcR5BPV9Ll5RoT7xz2aSLoP")
        ]
        
        for menu in menus {
            let newMenu = NSEntityDescription.insertNewObject(forEntityName: "Menus", into: context) as! Menus
            newMenu.name = menu.name
            newMenu.imageUrl = menu.imageUrl
        }
        
        do {
            try context.save()
        } catch _ {
        }
    }
    
    fileprivate func seedUsers() {
        let users = [
            (name: "Vegeta Doe", email: "vegeta@doe.com", password: "12345")
        ]
        
        for user in users {
            let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context) as! Users
            newUser.name = user.name
            newUser.email = user.email
            newUser.password = user.password
        }
        
        do {
            try context.save()
        } catch _ {
        }
    }
    
//    fileprivate func seedUsers() {
//        let classificationFetchRequest = NSFetchRequest<Classification>(entityName: "Classification")
//        let allClassifications = try! context.fetch(classificationFetchRequest)
//
//        let manatee = allClassifications.filter({(c: Classification) -> Bool in
//            return c.family == "Trichechidae"
//        }).first
//
//        let monkey = allClassifications.filter({(c: Classification) -> Bool in
//            return c.family == "Atelidae"
//        }).first
//
//        let bat = allClassifications.filter({(c: Classification) -> Bool in
//            return c.family == "Phyllostomidae"
//        }).first
//
//
//        let zooFetchRequest = NSFetchRequest<Zoo>(entityName: "Zoo")
//        let allZoos = try! context.fetch(zooFetchRequest)
//
//        let oklahomaCityZoo = allZoos.filter({ (z: Zoo) -> Bool in
//            return z.name == "Oklahoma City Zoo"
//        }).first
//
//        let sanDiegoZoo = allZoos.filter({ (z: Zoo) -> Bool in
//            return z.name == "San Diego Zoo"
//        }).first
//
//
//        let lowryParkZoo = allZoos.filter({ (z: Zoo) -> Bool in
//            return z.name == "Lowry Park Zoo"
//        }).first
//
//        let animals = [
//            (commonName: "Pygmy Fruit-eating Bat", habitat: "Flying Mamals Exhibit", classification: bat!, zoos: NSSet(array: [lowryParkZoo!, oklahomaCityZoo!, sanDiegoZoo!])),
//            (commonName: "Mantled Howler", habitat: "Primate Exhibit", classification: monkey!, zoos: NSSet(array: [sanDiegoZoo!, lowryParkZoo!])),
//            (commonName: "Geoffroy’s Spider Monkey", habitat: "Primate Exhibit", classification: monkey!, zoos: NSSet(array: [sanDiegoZoo!])),
//            (commonName: "West Indian Manatee", habitat: "Aquatic Mamals Exhibit", classification: manatee!, zoos: NSSet(array: [lowryParkZoo!]))
//        ]
//
//        for animal in animals {
//            let newAnimal = NSEntityDescription.insertNewObject(forEntityName: "Animal", into: context) as! Animal
//            newAnimal.commonName = animal.commonName
//            newAnimal.habitat = animal.habitat
//            newAnimal.classification = animal.classification
//            newAnimal.zoos = animal.zoos
//        }
//
//        do {
//            try context.save()
//        } catch _ {
//        }
//    }
//
//
//    public func printAllZoos() {
//        let zooFetchRequest = NSFetchRequest<Zoo>(entityName: "Zoo")
//        let primarySortDescriptor = NSSortDescriptor(key: "name", ascending: true)
//
//        zooFetchRequest.sortDescriptors = [primarySortDescriptor]
//
//        let allZoos = try! context.fetch(zooFetchRequest)
//
//        for zoo in allZoos {
//            print("Zoo Name: \(zoo.name)\nLocation: \(zoo.location) \n-------\n", terminator: "")
//        }
//    }
//
//    public func printAllClassifications() {
//        let classificationFetchRequest = NSFetchRequest<Classification>(entityName: "Classification")
//        let primarySortDescriptor = NSSortDescriptor(key: "family", ascending: true)
//
//        classificationFetchRequest.sortDescriptors = [primarySortDescriptor]
//
//        let allClassifications = try! context.fetch(classificationFetchRequest)
//
//        for classification in allClassifications {
//            print("Scientific Classification: \(classification.scientificClassification)\nOrder: \(classification.order)\nFamily: \(classification.family) \n-------\n", terminator: "")
//        }
//    }
//
//    public func printAllAnimals() {
//        let animalFetchRequest = NSFetchRequest<Animal>(entityName: "Animal")
//        let primarySortDescriptor = NSSortDescriptor(key: "habitat", ascending: true)
//
//        animalFetchRequest.sortDescriptors = [primarySortDescriptor]
//
//        let allAnimals = try! context.fetch(animalFetchRequest)
//
//        for animal in allAnimals {
//            print("\(animal.commonName), a member of the \(animal.classification.family) family, lives in the \(animal.habitat) at the following zoos:\n", terminator: "")
//            for zooElement in animal.zoos {
//                if let zoo = zooElement as? Zoo {
//                    print("> \(zoo.name)\n", terminator: "")
//                }
//            }
//            print("-------\n", terminator: "")
//        }
//    }
}
