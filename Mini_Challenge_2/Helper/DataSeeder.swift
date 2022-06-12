//
//  DataSeeder.swift
//  Mini_Challenge_2
//
//  Created by feedloop on 12/06/22.
//

import Foundation
import CoreData

public class DataSeeder {
    let context: NSManagedObjectContext
    var restoIndoVegan: Restaurants
    var dharmaKitchen: Restaurants
    var grasslandVegetarian: Restaurants
    var vegetusVegetarian: Restaurants
    var cheEnVegetarian: Restaurants
    var starbucks: Restaurants
    var kayuKayu: Restaurants
    var tamanSantap: Restaurants
    var formaggioCoffeResto: Restaurants
    
    init(context: NSManagedObjectContext) {
        self.context = context
        self.restoIndoVegan = Restaurants(context: context)
        self.dharmaKitchen = Restaurants(context: context)
        self.grasslandVegetarian = Restaurants(context: context)
        self.vegetusVegetarian = Restaurants(context: context)
        self.cheEnVegetarian = Restaurants(context: context)
        self.starbucks = Restaurants(context: context)
        self.kayuKayu = Restaurants(context: context)
        self.tamanSantap = Restaurants(context: context)
        self.formaggioCoffeResto = Restaurants(context: context)
    }

    public func process() {
        let restaurantsFetchRequest = NSFetchRequest<Restaurants>(entityName: "Restaurants")
        let allRestaurants = try! context.fetch(restaurantsFetchRequest)
        
        if !allRestaurants.isEmpty { return }
        
        print("seeding data to database is starting...")
        seedRestaurants()
        
        restoIndoVegan = allRestaurants.filter({(r: Restaurants) -> Bool in
            return r.name == "Resto Indo Vegan"
        }).first!
        dharmaKitchen = allRestaurants.filter({(r: Restaurants) -> Bool in
            return r.name == "Dharma Kitchen"
        }).first!
        grasslandVegetarian = allRestaurants.filter({(r: Restaurants) -> Bool in
            return r.name == "Grassland Vegetarian Restaurant"
        }).first!
        vegetusVegetarian = allRestaurants.filter({(r: Restaurants) -> Bool in
            return r.name == "Vegetus Vegetarian"
        }).first!
        cheEnVegetarian = allRestaurants.filter({(r: Restaurants) -> Bool in
            return r.name == "Che En Vegetarian"
        }).first!
        starbucks = allRestaurants.filter({(r: Restaurants) -> Bool in
            return r.name == "Starbucks"
        }).first!
        kayuKayu = allRestaurants.filter({(r: Restaurants) -> Bool in
            return r.name == "Kayu-Kayu Restaurant"
        }).first!
        tamanSantap = allRestaurants.filter({(r: Restaurants) -> Bool in
            return r.name == "Taman Santap Rumah Kayu"
        }).first!
        formaggioCoffeResto = allRestaurants.filter({(r: Restaurants) -> Bool in
            return r.name == "Formaggio Coffee and Resto"
        }).first!
        
        seedMenus()
        seedUsers()
        print("seeding data to database success")
    }
    
    fileprivate func seedRestaurants() {
        let restaurants = [
            (name: "Resto Indo Vegan", rating: 4.5, openHours: "07:00 - 18:00", phone: "0811953539", priceMin: "10000", priceMax: "60000", address: "Jalan Duri Selatan 1 No. 9, RT.06/ RW.02, RT.6/RW.2, Duri Sel., Kec. Tambora, Kota Jakarta Barat, Daerah Khusus Ibukota Jakarta 11270", imageUrl: "https://drive.google.com/uc?id=1eQa7DP1a1fC9gkjBvg24XJSaJkEDeUFW", latitude: 0.0, longitude: 0.0, vegeResto: true, city: "Jakarta", kecamatan: "Tambora"),
            (name: "Dharma Kitchen", rating: 4.5, openHours: "10:00 - 21:00", phone: "0216618302", priceMin: "75000", priceMax: "200000", address: "Jl. Pluit Kencana Raya No.124, RT.10/RW.7, Pluit, Kec. Penjaringan, Kota Jkt Utara, Daerah Khusus Ibukota Jakarta 14450", imageUrl: "https://drive.google.com/uc?id=1mpJh9v98tJeahcZIFpsZNPlxZkyxEn2q", latitude: 0.0, longitude: 0.0, vegeResto: true, city: "Jakarta", kecamatan: "Penjaringan"),
            (name: "Grassland Vegetarian Restaurant", rating: 4.5, openHours: "10:00 - 21:00", phone: "02129414533", priceMin: "10000", priceMax: "50000", address: "Jl. Hadiah 1 No.1564A, RT.7/RW.2, Jelambar, Kec. Grogol petamburan, Kota Jakarta", imageUrl: "https://drive.google.com/uc?id=1gboIULBnm7PdwGKYIRan75D5pK2e-6eG", latitude: 0.0, longitude: 0.0, vegeResto: true, city: "Jakarta", kecamatan: "Grogol Petamburan"),
            (name: "Vegetus Vegetarian", rating: 4.5, openHours: "09:00 - 22:00", phone: "083876501618", priceMin: "50000", priceMax: "200000", address: "Jl. Pluit Karang Timur, Blok O-8 Timur No.38-39, RT.5/RW.14, Pluit, Penjaringan, RT.5/RW.14, Pluit, Kec. Penjaringan, Kota Jkt Utara, Daerah Khusus Ibukota Jakarta 14450", imageUrl: "https://drive.google.com/uc?id=1V9n_XKuDsbUtTNaDQWfVRvTvmt--bCm_", latitude: 0.0, longitude: 0.0, vegeResto: true, city: "Jakarta", kecamatan: "Penjaringan"),
            (name: "Che En Vegetarian", rating: 4.5, openHours: "07:00 - 19:00", phone: "0216413523", priceMin: "5000", priceMax: "100000", address: "Gg. 22 No.11 B, RT.1/RW.1, Pademangan Tim., Kec. Pademangan, Kota Jkt Utara, Daerah Khusus Ibukota Jakarta 14410", imageUrl: "https://drive.google.com/uc?id=1DM9PYHzJTAyc3zT-p59JxVW94SklNU3l", latitude: 0.0, longitude: 0.0, vegeResto: true, city: "Jakarta", kecamatan: "Pademangan"),
            (name: "Starbucks", rating: 4.6, openHours: "06:00 - 22:00", phone: "02139833377", priceMin: "20000", priceMax: "60000", address: "Jl. M.H. Thamrin No.9, RW.1, Kb. Sirih, Kec. Menteng, Kota Jakarta Pusat, Daerah Khusus Ibukota Jakarta 10340", imageUrl: "", latitude: 0.0, longitude: 0.0, vegeResto: false, city: "Jakarta", kecamatan: "Menteng"),
            (name: "Kayu-Kayu Restaurant", rating: 4.0, openHours: "10:00 - 22:00", phone: "081318002828", priceMin: "10000", priceMax: "350000", address: "Jl. Jalur Sutera No.28A, Pakualam, Kec. Serpong Utara, Kota Tangerang Selatan, Banten 15325", imageUrl: "https://drive.google.com/uc?id=1z1i63WVWTdCjc3m3gjYRFEMoM_gEwvtX", latitude: 0.0, longitude: 0.0, vegeResto: false, city: "Tangerang", kecamatan: "Serpong Utara"),
            (name: "Taman Santap Rumah Kayu", rating: 4.5, openHours: "10:00 - 22:00", phone: "02154212011", priceMin: "15000", priceMax: "300000", address: "Jl. Ki Hajar Dewantara SKL No. 002, Pakulonan Bar., Kec. Klp. Dua, Kabupaten Tangerang, Banten 15810", imageUrl: "https://drive.google.com/uc?id=1CFRtD39_ZJbvZD9w7kGN2zV71Unl3EWB", latitude: 0.0, longitude: 0.0, vegeResto: false, city: "Tangerang", kecamatan: "Kelapa Dua"),
            (name: "Formaggio Coffee and Resto", rating: 4.5, openHours: "10:00 - 22:00", phone: "02155783238", priceMin: "20000", priceMax: "60000", address: "Jl. Nyimas Melati No.A2, RT.2/RW.1, Sukarasa, Kec. Tangerang, Kota Tangerang, Banten 15111", imageUrl: "https://drive.google.com/uc?id=1RuwaZ1ITF6XACBQZPu6w5ACW4bgAknXr", latitude: 0.0, longitude: 0.0, vegeResto: false, city: "Tangerang", kecamatan: "Tangerang"),
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
            (name: "Asinan Bogor", imageUrl: "https://drive.google.com/uc?id=1hyS-ryw5HWKLMd8cu3bnTgJ5Qf_sYDsk", restaurant: kayuKayu),
            (name: "Breakfast Set", imageUrl: "https://drive.google.com/uc?id=1ksVZMsY4dgTeULiS4E9hOkkJhfA6rrxF", restaurant: kayuKayu),
            (name: "Enoki Jamur Goreng", imageUrl: "https://drive.google.com/uc?id=1gjMRAeTE9vyN0LARtQYvRQSpJVUpMDp9", restaurant: kayuKayu),
            (name: "Martabak Vegie", imageUrl: "https://drive.google.com/uc?id=1uLf4UoC8xXfGqdNV3tmbschtXgbO8Vxr", restaurant: kayuKayu),
            (name: "Terong Balado", imageUrl: "https://drive.google.com/uc?id=1AbD2scdC09SqZEJ0p4Vk-JTKP-dLjI17", restaurant: kayuKayu),
            (name: "Kangkung Balacan", imageUrl: "https://drive.google.com/uc?id=1EKxqW3_1hwA4oDCmxkp61bSEQvmh5zvd", restaurant: tamanSantap),
            (name: "Kangkung Cah Jamur", imageUrl: "https://drive.google.com/uc?id=1KDK3FIh6FEaZ5bbg8i9aOjWCgDG0xciE", restaurant: tamanSantap),
            (name: "Kangkung Plecing", imageUrl: "https://drive.google.com/uc?id=1GkYCFpAcrMWdOPKYLrj8QKhOD-qJPWlU", restaurant: tamanSantap),
            (name: "Tauge Cah Polos", imageUrl: "https://drive.google.com/uc?id=1KDQhFIjsduPMmSMgjsB8Cqs9KYGhdCkN", restaurant: tamanSantap),
            (name: "Terong Goreng", imageUrl: "https://drive.google.com/uc?id=1uoQw5Xm-kYaqHkVL5WXFRCCoSIMNupok", restaurant: tamanSantap),
            (name: "Caesar Salad", imageUrl: "https://drive.google.com/uc?id=1GeKCLu5GfA_PUnu-SsU02vdCvnKzgZs8", restaurant: formaggioCoffeResto),
            (name: "Corn and Carrot Soup", imageUrl: "https://drive.google.com/uc?id=13J1iIg-THOaMO2oUZk8PDLdYKrCF_qZi", restaurant: formaggioCoffeResto),
            (name: "Mushroom Cream Soup", imageUrl: "https://drive.google.com/uc?id=1fwP0k1jSZMyd55uOKZC_jaLQJ2Zc_BLf", restaurant: formaggioCoffeResto),
            (name: "Nacos Con Fungi", imageUrl: "https://drive.google.com/uc?id=1A9Uc_0H8KsQZcGGSvYxCMUYhQ2KrTvW8", restaurant: formaggioCoffeResto),
            (name: "Pad Thai", imageUrl: "https://drive.google.com/uc?id=1JiPQbnR--XcR5BPV9Ll5RoT7xz2aSLoP", restaurant: formaggioCoffeResto)
        ]
        
        for menu in menus {
            let newMenu = NSEntityDescription.insertNewObject(forEntityName: "Menus", into: context) as! Menus
            newMenu.name = menu.name
            newMenu.imageUrl = menu.imageUrl
            newMenu.restaurant = menu.restaurant
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
            newUser.restaurants = NSSet(array: [grasslandVegetarian, kayuKayu, starbucks])
        }
        
        do {
            try context.save()
        } catch _ {
        }
    }
}
