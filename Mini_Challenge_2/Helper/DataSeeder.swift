//
//  DataSeeder.swift
//  Mini_Challenge_2
//
//  Created by feedloop on 12/06/22.
//

import Foundation
import CoreData
import UIKit

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
    var vegeta: Users
    
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
        self.vegeta = Users(context: context)
    }

    public func process() {
        var allRestaurants = try! context.fetch(Restaurants.fetchRequest())
        var nilRows = allRestaurants.filter({(r: Restaurants) -> Bool in
            return r.name == nil
        })
        for row in nilRows {
            context.delete(row)
            do {
                try context.save()
            } catch _ {
            }
        }
        
        let checkUser = try! context.fetch(Users.fetchRequest())
        let r = checkUser.filter({(r: Users) -> Bool in
            return r.name == "Vegeta Doe"
        }).first ?? Users(context: context)
        
        var users = try! context.fetch(Users.fetchRequest())
        var nilUsersRows = users.filter({(u: Users) -> Bool in
            return u.name == nil
        })
        for row in nilUsersRows {
            context.delete(row)
            do {
                try context.save()
            } catch _ {
            }
        }
        
        if r.name == "Vegeta Doe" { return }
        
        print("seeding data to database is starting...")
        seedRestaurants()
        allRestaurants = try! context.fetch(Restaurants.fetchRequest())
        nilRows = allRestaurants.filter({(r: Restaurants) -> Bool in
            return r.name == nil
        })
        for row in nilRows {
            context.delete(row)
            do {
                try context.save()
            } catch _ {
            }
        }
        
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
        
        users = try! context.fetch(Users.fetchRequest())
        vegeta = users.filter({(u: Users) -> Bool in
            return u.name == "Vegeta Doe"
        }).first!
        
        seedReviews()
        
        nilUsersRows = users.filter({(u: Users) -> Bool in
            return u.name == nil
        })
        for row in nilUsersRows {
            context.delete(row)
            do {
                try context.save()
            } catch _ {
            }
        }
        print("seeding data to database success")
    }
    
    fileprivate func seedRestaurants() {
        let restoIndoVeganImg = UIImage(named: "Restaurant_Resto Indo Vegan")?.jpegData(compressionQuality: 1.0)
        let dharmaKitchenImg = UIImage(named: "Restaurant_Dharma Kitchen")?.jpegData(compressionQuality: 1.0)
        let grasslandVegetarianImg = UIImage(named: "Restaurant_Grassland")?.jpegData(compressionQuality: 1.0)
        let vegetusVegetarianImg = UIImage(named: "Restaurant_Vegetus")?.jpegData(compressionQuality: 1.0)
        let CheEnVegetarianImg = UIImage(named: "Restaurant_Che En")?.jpegData(compressionQuality: 1.0)
        let starbucksImg = UIImage(named: "Restaurant_Starbucks")?.jpegData(compressionQuality: 1.0)
        let formaggioImg = UIImage(named: "Tangerang_Formaggio")?.jpegData(compressionQuality: 1.0)
        let kayuKayuImg = UIImage(named: "Tangerang_Kayu-Kayu")?.jpegData(compressionQuality: 1.0)
        let tamanSantapImg = UIImage(named: "Tangerang_Taman Santap")?.jpegData(compressionQuality: 1.0)
        
        let restoIndoVeganImgMap = UIImage(named: "Resto Indo Vegan")?.jpegData(compressionQuality: 1.0)
        let dharmaKitchenImgMap = UIImage(named: "Dharma Kitchen")?.jpegData(compressionQuality: 1.0)
        let grasslandVegetarianImgMap = UIImage(named: "Grassland Vegetarian Restaurant")?.jpegData(compressionQuality: 1.0)
        let vegetusVegetarianImgMap = UIImage(named: "Vegetus Vegetarian")?.jpegData(compressionQuality: 1.0)
        let CheEnVegetarianImgMap = UIImage(named: "Che En Vegetarian")?.jpegData(compressionQuality: 1.0)
        let starbucksImgMap = UIImage(named: "Starbucks")?.jpegData(compressionQuality: 1.0)
        let formaggioImgMap = UIImage(named: "Formaggio Coffee _ Resto")?.jpegData(compressionQuality: 1.0)
        let kayuKayuImgMap = UIImage(named: "Kayu Kayu Restaurant")?.jpegData(compressionQuality: 1.0)
        let tamanSantapImgMap = UIImage(named: "Taman Santap Rumah Kayu")?.jpegData(compressionQuality: 1.0)
        
        let restaurants = [
            (name: "Resto Indo Vegan", rating: 4.0, openHours: "07:00 - 18:00", phone: "0811953539", priceMin: "10000", priceMax: "60000", address: "Jalan Duri Selatan 1 No. 9, RT.06/ RW.02, RT.6/RW.2, Duri Sel., Kec. Tambora, Kota Jakarta Barat, Daerah Khusus Ibukota Jakarta 11270", imageUrl: "https://drive.google.com/uc?id=1eQa7DP1a1fC9gkjBvg24XJSaJkEDeUFW", latitude: -6.16091552563978, longitude: 106.80619523969511, vegeResto: true, city: "Jakarta", kecamatan: "Tambora", image: restoIndoVeganImg),
            (name: "Dharma Kitchen", rating: 3.0, openHours: "10:00 - 21:00", phone: "0216618302", priceMin: "75000", priceMax: "200000", address: "Jl. Pluit Kencana Raya No.124, RT.10/RW.7, Pluit, Kec. Penjaringan, Kota Jkt Utara, Daerah Khusus Ibukota Jakarta 14450", imageUrl: "https://drive.google.com/uc?id=1mpJh9v98tJeahcZIFpsZNPlxZkyxEn2q", latitude: -6.119620138581436, longitude: 106.78849407789964, vegeResto: true, city: "Jakarta", kecamatan: "Penjaringan", image: dharmaKitchenImg),
            (name: "Grassland Vegetarian Restaurant", rating: 4.0, openHours: "10:00 - 21:00", phone: "02129414533", priceMin: "10000", priceMax: "50000", address: "Jl. Hadiah 1 No.1564A, RT.7/RW.2, Jelambar, Kec. Grogol petamburan, Kota Jakarta", imageUrl: "https://drive.google.com/uc?id=1gboIULBnm7PdwGKYIRan75D5pK2e-6eG", latitude: -6.161418660663324, longitude: 106.78157470302833, vegeResto: true, city: "Jakarta", kecamatan: "Grogol Petamburan", image: grasslandVegetarianImg),
            (name: "Vegetus Vegetarian", rating: 5.0, openHours: "09:00 - 22:00", phone: "083876501618", priceMin: "50000", priceMax: "200000", address: "Jl. Pluit Karang Timur, Blok O-8 Timur No.38-39, RT.5/RW.14, Pluit, Penjaringan, RT.5/RW.14, Pluit, Kec. Penjaringan, Kota Jkt Utara, Daerah Khusus Ibukota Jakarta 14450", imageUrl: "https://drive.google.com/uc?id=1V9n_XKuDsbUtTNaDQWfVRvTvmt--bCm_", latitude: -6.1222719045183265, longitude: 106.78334629139079, vegeResto: true, city: "Jakarta", kecamatan: "Penjaringan", image: vegetusVegetarianImg),
            (name: "Che En Vegetarian", rating: 5.0, openHours: "07:00 - 19:00", phone: "0216413523", priceMin: "5000", priceMax: "100000", address: "Gg. 22 No.11 B, RT.1/RW.1, Pademangan Tim., Kec. Pademangan, Kota Jkt Utara, Daerah Khusus Ibukota Jakarta 14410", imageUrl: "https://drive.google.com/uc?id=1DM9PYHzJTAyc3zT-p59JxVW94SklNU3l", latitude: -6.134237332933617, longitude: 106.84126431600886, vegeResto: true, city: "Jakarta", kecamatan: "Pademangan", image: CheEnVegetarianImg),
            (name: "Starbucks", rating: 4.0, openHours: "06:00 - 22:00", phone: "02139833377", priceMin: "20000", priceMax: "60000", address: "Jl. M.H. Thamrin No.9, RW.1, Kb. Sirih, Kec. Menteng, Kota Jakarta Pusat, Daerah Khusus Ibukota Jakarta 10340", imageUrl: "", latitude: -6.186636432957156, longitude: 106.82386064906369, vegeResto: false, city: "Jakarta", kecamatan: "Menteng", image: starbucksImg),
            (name: "Kayu-Kayu Restaurant", rating: 5.0, openHours: "10:00 - 22:00", phone: "081318002828", priceMin: "10000", priceMax: "350000", address: "Jl. Jalur Sutera No.28A, Pakualam, Kec. Serpong Utara, Kota Tangerang Selatan, Banten 15325", imageUrl: "https://drive.google.com/uc?id=1z1i63WVWTdCjc3m3gjYRFEMoM_gEwvtX", latitude: -6.232621398368496, longitude: 106.66053343928051, vegeResto: false, city: "Tangerang", kecamatan: "Serpong Utara", image: kayuKayuImg),
            (name: "Taman Santap Rumah Kayu", rating: 4.0, openHours: "10:00 - 22:00", phone: "02154212011", priceMin: "15000", priceMax: "300000", address: "Jl. Ki Hajar Dewantara SKL No. 002, Pakulonan Bar., Kec. Klp. Dua, Kabupaten Tangerang, Banten 15810", imageUrl: "https://drive.google.com/uc?id=1CFRtD39_ZJbvZD9w7kGN2zV71Unl3EWB", latitude: -6.238778671417341, longitude: 106.63809836440906, vegeResto: false, city: "Tangerang", kecamatan: "Kelapa Dua", image: tamanSantapImg),
            (name: "Formaggio Coffee and Resto", rating: 5.0, openHours: "10:00 - 22:00", phone: "02155783238", priceMin: "20000", priceMax: "60000", address: "Jl. Nyimas Melati No.A2, RT.2/RW.1, Sukarasa, Kec. Tangerang, Kota Tangerang, Banten 15111", imageUrl: "https://drive.google.com/uc?id=1RuwaZ1ITF6XACBQZPu6w5ACW4bgAknXr", latitude: -6.172003296055309, longitude: 106.63311005277136, vegeResto: false, city: "Tangerang", kecamatan: "Tangerang", image: formaggioImg),
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
            newRestaurant.vegeResto = restaurant.vegeResto
            newRestaurant.city = restaurant.city
            newRestaurant.kecamatan = restaurant.kecamatan
            newRestaurant.image = restaurant.image
            newRestaurant.imageMap = restaurant.imageMap
        }
        
        do {
            try context.save()
        } catch _ {
        }
    }
    
    fileprivate func seedMenus() {
        
        // Kayu-kayu Restaurant Menu
        let kayuAsinanImg = UIImage(named: "Kayu-Kayu 1 - Asinan Bogor")?.jpegData(compressionQuality: 1.0)
        let kayuBreakfastSetImg = UIImage(named: "Kayu-Kayu 2 - Breakfast Set")?.jpegData(compressionQuality: 1.0)
        let kayuEnokiImg = UIImage(named: "Kayu-Kayu 3 - Enoki Jamur Goreng")?.jpegData(compressionQuality: 1.0)
        let kayuMartabakVegieImg = UIImage(named: "Kayu-Kayu 4 - Martabak Vegie")?.jpegData(compressionQuality: 1.0)
        let kayuTerongBaladoImg = UIImage(named: "Kayu-Kayu 5 - Terong Balado")?.jpegData(compressionQuality: 1.0)
        
        // Taman Santap Restaurant Menu
        let tamanSantapKangkungBalacanImg = UIImage(named: "Taman Santap 1 - Kangkung Balacan")?.jpegData(compressionQuality: 1.0)
        let tamanSantapKangkungJamurImg = UIImage(named: "Taman Santap 2 - Kangkung Cah Jamur")?.jpegData(compressionQuality: 1.0)
        let tamanSantapKangkungPlecingImg = UIImage(named: "Taman Santap 3 - Kangkung Plecing")?.jpegData(compressionQuality: 1.0)
        let tamanSantapTaugePolosImg = UIImage(named: "Taman Santap 4 - Tauge Cah Polos")?.jpegData(compressionQuality: 1.0)
        let tamanSantapTerongGorengImg = UIImage(named: "Taman Santap 5 - Terong Goreng")?.jpegData(compressionQuality: 1.0)
        
        // Formaggio Restaurant Menu
        let formaggioCaesarImg = UIImage(named: "Formaggio 1 - Caesar Salad")?.jpegData(compressionQuality: 1.0)
        let formaggioCornSoupImg = UIImage(named: "Formaggio 2 - Corn And Carrot Soup")?.jpegData(compressionQuality: 1.0)
        let formaggioMushroomSoupImg = UIImage(named: "Formaggio 3 - Mushroom Cream Soup")?.jpegData(compressionQuality: 1.0)
        let formaggioNacosFungiImg = UIImage(named: "Formaggio 4 - Nacos Con Fungi")?.jpegData(compressionQuality: 1.0)
        let formaggioPadThaiImg = UIImage(named: "Formaggio 5 - Pad Thai")?.jpegData(compressionQuality: 1.0)
        
        // Che-En Restaurant Menu
        let CheEnVegetarian_1_MenuImg = UIImage(named: "Che En Vegetarian_1")?.jpegData(compressionQuality: 1.0)
        let CheEnVegetarian_2_MenuImg = UIImage(named: "Che En Vegetarian_2")?.jpegData(compressionQuality: 1.0)
        let CheEnVegetarian_3_MenuImg = UIImage(named: "Che En Vegetarian_3")?.jpegData(compressionQuality: 1.0)
        let CheEnVegetarian_4_MenuImg = UIImage(named: "Che En Vegetarian_4")?.jpegData(compressionQuality: 1.0)
        let CheEnVegetarian_5_MenuImg = UIImage(named: "Che En Vegetarian_5")?.jpegData(compressionQuality: 1.0)
        
        // Dharma Kitchen Restaurant Menu
        let DharmaKitchen_1_MenuImg = UIImage(named: "Dharma Kitchen_1")?.jpegData(compressionQuality: 1.0)
        let DharmaKitchen_2_MenuImg = UIImage(named: "Dharma Kitchen_2")?.jpegData(compressionQuality: 1.0)
        let DharmaKitchen_3_MenuImg = UIImage(named: "Dharma Kitchen_3")?.jpegData(compressionQuality: 1.0)
        let DharmaKitchen_4_MenuImg = UIImage(named: "Dharma Kitchen_4")?.jpegData(compressionQuality: 1.0)
        let DharmaKitchen_5_MenuImg = UIImage(named: "Dharma Kitchen_5")?.jpegData(compressionQuality: 1.0)
        
        // Grassland Kitchen Restaurant Menu
        let Grassland_1_MenuImg = UIImage(named: "Grassland_1")?.jpegData(compressionQuality: 1.0)
        let Grassland_2_MenuImg = UIImage(named: "Grassland_2")?.jpegData(compressionQuality: 1.0)
        let Grassland_3_MenuImg = UIImage(named: "Grassland_3")?.jpegData(compressionQuality: 1.0)
        let Grassland_4_MenuImg = UIImage(named: "Grassland_4")?.jpegData(compressionQuality: 1.0)
        let Grassland_5_MenuImg = UIImage(named: "Grassland_5")?.jpegData(compressionQuality: 1.0)
        
        // Resto Indo Kitchen Restaurant Menu
        let RestoIndo_1_MenuImg = UIImage(named: "Resto Indo_1")?.jpegData(compressionQuality: 1.0)
        let RestoIndo_2_MenuImg = UIImage(named: "Resto Indo_2")?.jpegData(compressionQuality: 1.0)
        let RestoIndo_3_MenuImg = UIImage(named: "Resto Indo_3")?.jpegData(compressionQuality: 1.0)
        let RestoIndo_4_MenuImg = UIImage(named: "Resto Indo_4")?.jpegData(compressionQuality: 1.0)
        let RestoIndo_5_MenuImg = UIImage(named: "Resto Indo_5")?.jpegData(compressionQuality: 1.0)
        
        // Starbucks Restaurant Menu
        let Starbucks_1_MenuImg = UIImage(named: "Starbucks_1")?.jpegData(compressionQuality: 1.0)
        let Starbucks_2_MenuImg = UIImage(named: "Starbucks_2")?.jpegData(compressionQuality: 1.0)
        let Starbucks_3_MenuImg = UIImage(named: "Starbucks_3")?.jpegData(compressionQuality: 1.0)
        let Starbucks_4_MenuImg = UIImage(named: "Starbucks_4")?.jpegData(compressionQuality: 1.0)
        let Starbucks_5_MenuImg = UIImage(named: "Starbucks_5")?.jpegData(compressionQuality: 1.0)
        
        // Vegetus Vegetarian Restaurant Menu
        let VegetusVegetarian_1_MenuImg = UIImage(named: "Vegetus Vegetarian_1")?.jpegData(compressionQuality: 1.0)
        let VegetusVegetarian_2_MenuImg = UIImage(named: "Vegetus Vegetarian_2")?.jpegData(compressionQuality: 1.0)
        let VegetusVegetarian_3_MenuImg = UIImage(named: "Vegetus Vegetarian_3")?.jpegData(compressionQuality: 1.0)
        let VegetusVegetarian_4_MenuImg = UIImage(named: "Vegetus Vegetarian_4")?.jpegData(compressionQuality: 1.0)
        let VegetusVegetarian_5_MenuImg = UIImage(named: "Vegetus Vegetarian_5")?.jpegData(compressionQuality: 1.0)
        
        
        
        let menus = [
            (name: "Asinan Bogor", imageUrl: "https://drive.google.com/uc?id=1hyS-ryw5HWKLMd8cu3bnTgJ5Qf_sYDsk", restaurant: kayuKayu, image: kayuAsinanImg),
            (name: "Breakfast Set", imageUrl: "https://drive.google.com/uc?id=1ksVZMsY4dgTeULiS4E9hOkkJhfA6rrxF", restaurant: kayuKayu, image: kayuBreakfastSetImg),
            (name: "Enoki Jamur Goreng", imageUrl: "https://drive.google.com/uc?id=1gjMRAeTE9vyN0LARtQYvRQSpJVUpMDp9", restaurant: kayuKayu, image: kayuEnokiImg),
            (name: "Martabak Vegie", imageUrl: "https://drive.google.com/uc?id=1uLf4UoC8xXfGqdNV3tmbschtXgbO8Vxr", restaurant: kayuKayu, image: kayuMartabakVegieImg),
            (name: "Terong Balado", imageUrl: "https://drive.google.com/uc?id=1AbD2scdC09SqZEJ0p4Vk-JTKP-dLjI17", restaurant: kayuKayu, image: kayuTerongBaladoImg),
            (name: "Kangkung Balacan", imageUrl: "https://drive.google.com/uc?id=1EKxqW3_1hwA4oDCmxkp61bSEQvmh5zvd", restaurant: tamanSantap, image: tamanSantapKangkungBalacanImg),
            (name: "Kangkung Cah Jamur", imageUrl: "https://drive.google.com/uc?id=1KDK3FIh6FEaZ5bbg8i9aOjWCgDG0xciE", restaurant: tamanSantap, image: tamanSantapKangkungJamurImg),
            (name: "Kangkung Plecing", imageUrl: "https://drive.google.com/uc?id=1GkYCFpAcrMWdOPKYLrj8QKhOD-qJPWlU", restaurant: tamanSantap, image: tamanSantapKangkungPlecingImg),
            (name: "Tauge Cah Polos", imageUrl: "https://drive.google.com/uc?id=1KDQhFIjsduPMmSMgjsB8Cqs9KYGhdCkN", restaurant: tamanSantap, image: tamanSantapTaugePolosImg),
            (name: "Terong Goreng", imageUrl: "https://drive.google.com/uc?id=1uoQw5Xm-kYaqHkVL5WXFRCCoSIMNupok", restaurant: tamanSantap, image: tamanSantapTerongGorengImg),
            (name: "Caesar Salad", imageUrl: "https://drive.google.com/uc?id=1GeKCLu5GfA_PUnu-SsU02vdCvnKzgZs8", restaurant: formaggioCoffeResto, image: formaggioCaesarImg),
            (name: "Corn and Carrot Soup", imageUrl: "https://drive.google.com/uc?id=13J1iIg-THOaMO2oUZk8PDLdYKrCF_qZi", restaurant: formaggioCoffeResto, image: formaggioCornSoupImg),
            (name: "Mushroom Cream Soup", imageUrl: "https://drive.google.com/uc?id=1fwP0k1jSZMyd55uOKZC_jaLQJ2Zc_BLf", restaurant: formaggioCoffeResto, image: formaggioMushroomSoupImg),
            (name: "Nacos Con Fungi", imageUrl: "https://drive.google.com/uc?id=1A9Uc_0H8KsQZcGGSvYxCMUYhQ2KrTvW8", restaurant: formaggioCoffeResto, image: formaggioNacosFungiImg),
            (name: "Pad Thai", imageUrl: "https://drive.google.com/uc?id=1JiPQbnR--XcR5BPV9Ll5RoT7xz2aSLoP", restaurant: formaggioCoffeResto, image: formaggioPadThaiImg),
            (name: "Che En Menu Image1", imageUrl: "https://drive.google.com/file/d/1p3Kfl-SMB4Ap-e7hieJs624_JjLzZZrg/view?usp=sharing", restaurant: cheEnVegetarian, image: CheEnVegetarian_1_MenuImg),
            (name: "Che En Menu Image2", imageUrl: "https://drive.google.com/file/d/13-7CHnSoZ_3EWVYa8QdG-hcrPRF36nIE/view?usp=sharing", restaurant: cheEnVegetarian, image: CheEnVegetarian_2_MenuImg),
            (name: "Che En Menu Image3", imageUrl: "https://drive.google.com/file/d/1E64ihfEiswr_48j-0MCoRzJGpQW6f0Ql/view?usp=sharing", restaurant: cheEnVegetarian, image: CheEnVegetarian_3_MenuImg),
            (name: "Che En Menu Image4", imageUrl: "https://drive.google.com/file/d/1bI-d4fplwjVz5omLzLJ0E1SGPhT-w3kP/view?usp=sharing", restaurant: cheEnVegetarian, image: CheEnVegetarian_4_MenuImg),
            (name: "Che En Menu Image5", imageUrl: "https://drive.google.com/file/d/1zdMaAIaREf2VCRYoVvcgYBNRzY3CoBSl/view?usp=sharing", restaurant: cheEnVegetarian, image: CheEnVegetarian_5_MenuImg),
            //
            (name: "Dharma Kitchen Menu Image1", imageUrl: "https://drive.google.com/file/d/16_1LGU1YPjYbytgU3uObRenu3z8zLzat/view?usp=sharing", restaurant: dharmaKitchen, image: DharmaKitchen_1_MenuImg),
            (name: "Dharma Kitchen Menu Image2", imageUrl: "https://drive.google.com/file/d/1Hk6P9DoelcsoT6bQsT0wrKzKXBExcO5i/view?usp=sharing", restaurant: dharmaKitchen, image: DharmaKitchen_2_MenuImg),
            (name: "Dharma Kitchen Menu Image3", imageUrl: "https://drive.google.com/file/d/1WnP5XsQiPJx-8jUc_EW6LVtKcQr40eN2/view?usp=sharing", restaurant: dharmaKitchen, image: DharmaKitchen_3_MenuImg),
            (name: "Dharma Kitchen Menu Image4", imageUrl: "https://drive.google.com/file/d/1tqWU82GOjmjhOfW905VqUlCUfn_UcgIO/view?usp=sharing", restaurant: dharmaKitchen, image: DharmaKitchen_4_MenuImg),
            (name: "Dharma Kitchen Menu Image5", imageUrl: "https://drive.google.com/file/d/1tm9rXOyvEBpoVZxbERVVpgEka1o02ilE/view?usp=sharing", restaurant: dharmaKitchen, image: DharmaKitchen_5_MenuImg),
            //
            (name: "Grassland Menu Image1", imageUrl: "https://drive.google.com/file/d/14hF7NOMkNYG-8eU26WXrnmx3i5c2oxYB/view?usp=sharing", restaurant: grasslandVegetarian, image: Grassland_1_MenuImg),
            (name: "Grassland Menu Image2", imageUrl: "https://drive.google.com/file/d/1mlmesCut4oz-_Ji5gYAoUHDYbGfa_FRf/view?usp=sharing", restaurant: grasslandVegetarian, image: Grassland_2_MenuImg),
            (name: "Grassland Menu Image3", imageUrl: "https://drive.google.com/file/d/15hIkssMkLlwhct4tZ5yECDBhbNO335zF/view?usp=sharing", restaurant: grasslandVegetarian, image: Grassland_3_MenuImg),
            (name: "Grassland Menu Image4", imageUrl: "https://drive.google.com/file/d/1YMo1zsuUbD3nNQv_leNoMrAmUZRlGUPI/view?usp=sharing", restaurant: grasslandVegetarian, image: Grassland_4_MenuImg),
            (name: "Grassland Menu Image5", imageUrl: "https://drive.google.com/file/d/18xhfk4YK4tvEsPmzFk_Ut9pIi8WXb2f_/view?usp=sharing", restaurant: grasslandVegetarian, image: Grassland_5_MenuImg),
            //
            (name: "Restaurant Indo Menu Image1", imageUrl: "https://drive.google.com/file/d/1SaIrej5rQx4lZXqIgIUSVfArQALquvMM/view?usp=sharing", restaurant: restoIndoVegan, image: RestoIndo_1_MenuImg),
            (name: "Restaurant Indo Menu Image2", imageUrl: "https://drive.google.com/file/d/1ZdnvJ0cB8NlH4gyQRuM7Aixnkk4BKsMs/view?usp=sharing", restaurant: restoIndoVegan, image: RestoIndo_2_MenuImg),
            (name: "Restaurant Indo Menu Image3", imageUrl: "https://drive.google.com/file/d/10QNprHW8nYhDv99ZETchuWUytFJIrYMw/view?usp=sharing", restaurant: restoIndoVegan, image: RestoIndo_3_MenuImg),
            (name: "Restaurant Indo Menu Image4", imageUrl: "https://drive.google.com/file/d/1-fTvzbXmtSs4hsQaa3WqKiA3xEPphwXo/view?usp=sharing", restaurant: restoIndoVegan, image: RestoIndo_4_MenuImg),
            (name: "Restaurant Indo Menu Image5", imageUrl: "https://drive.google.com/file/d/1QVQpVqJ4vEn4aW34UBsF8oQBbf5oUA1a/view?usp=sharing", restaurant: restoIndoVegan, image: RestoIndo_5_MenuImg),

            //
            (name: "Starbucks Menu Image1", imageUrl: "https://drive.google.com/file/d/1mmF0ypl3VYmOXGeO4E4MmBQduzIVJD2E/view?usp=sharing", restaurant: starbucks, image: Starbucks_1_MenuImg),
            (name: "Starbucks Menu Image2", imageUrl: "https://drive.google.com/file/d/1aKeimX89-AUlQav3-fzrpAfQezl3i5Gr/view?usp=sharing", restaurant: starbucks, image: Starbucks_2_MenuImg),
            (name: "Starbucks Menu Image3", imageUrl: "https://drive.google.com/file/d/1KJflF7QqgNlWPrZmH93vaZ8OJ1lqQv_t/view?usp=sharing", restaurant: starbucks, image: Starbucks_3_MenuImg),
            (name: "Starbucks Menu Image4", imageUrl: "https://drive.google.com/file/d/1EaTFOmZDWxgunl1XQo5VVH12HFVktMF7/view?usp=sharing", restaurant: starbucks, image: Starbucks_4_MenuImg),
            (name: "Starbucks Menu Image5", imageUrl: "https://drive.google.com/file/d/10-yvdrBEuyL1NkbWp9Fg-kJcw56Q_ux9/view?usp=sharing", restaurant: starbucks, image: Starbucks_5_MenuImg),

            //
            (name: "Vegetus Vegetarian Menu Image1", imageUrl: "https://drive.google.com/file/d/15ad-DNTDwP366sGZlcS-Zd6YkCKyOvWj/view?usp=sharing", restaurant: vegetusVegetarian, image: VegetusVegetarian_1_MenuImg),
            (name: "Vegetus Vegetarian Menu Image2", imageUrl: "https://drive.google.com/file/d/1jPwz2XXVaYgYWWeG8EyRVmPHGXWR58v4/view?usp=sharing", restaurant: vegetusVegetarian, image: VegetusVegetarian_2_MenuImg),
            (name: "Vegetus Vegetarian Menu Image3", imageUrl: "https://drive.google.com/file/d/1Kg7XI2dKK4J8fh8OienZNYn6iwpWsPMP/view?usp=sharing", restaurant: vegetusVegetarian, image: VegetusVegetarian_3_MenuImg),
            (name: "Vegetus Vegetarian Menu Image4", imageUrl: "https://drive.google.com/file/d/1mtFVHpYFB9y14OqvIT-kFNLp_N5fU2ae/view?usp=sharing", restaurant: vegetusVegetarian, image: VegetusVegetarian_4_MenuImg),
            (name: "Vegetus Vegetarian Menu Image5", imageUrl: "https://drive.google.com/file/d/1N0rsvRCjHyL9h0Y7ZhdgqeWJ3KH7Ry1-/view?usp=sharing", restaurant: vegetusVegetarian, image: VegetusVegetarian_5_MenuImg),
            
        ]
        
        for menu in menus {
            let newMenu = NSEntityDescription.insertNewObject(forEntityName: "Menus", into: context) as! Menus
            newMenu.name = menu.name
            newMenu.imageUrl = menu.imageUrl
            newMenu.restaurant = menu.restaurant
            newMenu.image = menu.image
        }
        
        do {
            try context.save()
        } catch _ {
        }
    }
    
    fileprivate func seedUsers() {
        let vegetaImg = UIImage(named: "vegeta")?.jpegData(compressionQuality: 1.0)
        let users = [
            (name: "Vegeta Doe", email: "vegeta@doe.com", password: "12345", image: vegetaImg)
        ]
        
        for user in users {
            let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context) as! Users
            newUser.name = user.name
            newUser.email = user.email
            newUser.password = user.password
            newUser.image = user.image
            newUser.restaurants = NSSet(array: [grasslandVegetarian, kayuKayu, starbucks])
        }
        
        do {
            try context.save()
        } catch _ {
        }
    }
    
    fileprivate func seedReviews() {
        let formaggioCaesarImg = UIImage(named: "Formaggio 1 - Caesar Salad")?.jpegData(compressionQuality: 1.0)
        let kayuAsinanImg = UIImage(named: "Kayu-Kayu 1 - Asinan Bogor")?.jpegData(compressionQuality: 1.0)
        
        let reviews = [
            (comment: "Best vegetarian food I’ve ever tried! U guys should try it", rate: 5, date: "2022-05-15", image: formaggioCaesarImg, restaurant: formaggioCoffeResto, user: vegeta),
            (comment: "Nice place to eat", rate: 5, date: "2022-06-15", image: nil, restaurant: tamanSantap, user: vegeta),
            (comment: "This resto has best asinan in town", rate: 5, date: "2022-06-15", image: kayuAsinanImg, restaurant: kayuKayu, user: vegeta)
        ]
        
        for review in reviews {
            let newReview = NSEntityDescription.insertNewObject(forEntityName: "Reviews", into: context) as! Reviews
            newReview.comment = review.comment
            newReview.rate = Int16(review.rate)
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            newReview.date = formatter.date(from: review.date)
            newReview.image = review.image
            newReview.restaurant = review.restaurant
            newReview.user = review.user
        }
        
        do {
            try context.save()
        } catch _ {
        }
    }
}
