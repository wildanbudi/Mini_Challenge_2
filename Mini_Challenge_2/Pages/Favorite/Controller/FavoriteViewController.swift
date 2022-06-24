//
//  FavoriteViewController.swift
//  Mini_Challenge_2
//
//  Created by feedloop on 15/06/22.
//

import UIKit

class FavoriteViewController: UIViewController, UISearchBarDelegate {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var usersData: [Users]!
    var favRestaurantsData: [Restaurants]!
    var filteredData: [Restaurants]!
    let searchBarInstance = SearchBar()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var favoriteTableView: UITableView!
    @IBOutlet weak var filterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllUsers()
        
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        
        searchBar.delegate = self
        
        
        let user = usersData.filter({(r: Users) -> Bool in
            return r.name == "Vegeta Doe"
        }).first ?? Users(context: context)
        
        favRestaurantsData = (user.restaurants!.allObjects as! [Restaurants])
        filteredData = favRestaurantsData
        
        let locationButton =  UIButton(type: .custom)
        locationButton.setImage(UIImage(named: "location"), for: .normal)
        locationButton.tintColor = UIColor(red: 90/255, green: 141/255, blue: 38/255, alpha: 1)
        locationButton.frame = CGRect(x: 0, y: 5, width: 0, height: 31)
        let locationLabel = UILabel(frame: CGRect(x: -70, y: 5, width: 100, height: 20))// set position of label
        locationLabel.text = "Location"
        locationLabel.textColor = UIColor.black
        locationLabel.backgroundColor = UIColor.clear
        locationButton.addSubview(locationLabel)
        locationButton.addTarget(self, action: #selector(showLocation), for: .touchUpInside)
        let rightBarButton = UIBarButtonItem(customView: locationButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        let profileButton =  UIButton(type: .custom)
        profileButton.setImage(UIImage(systemName: "person.circle.fill"), for: .normal)
        profileButton.tintColor = UIColor(red: 90/255, green: 141/255, blue: 38/255, alpha: 1)
        profileButton.frame = CGRect(x: 0, y: 5, width: 0, height: 31)
        let profileLabel = UILabel(frame: CGRect(x: 30, y: 5, width: 100, height: 20))// set position of label
        profileLabel.text = user.name
        profileLabel.textColor = UIColor.black
        profileLabel.backgroundColor =   UIColor.clear
        profileButton.addSubview(profileLabel)
        profileButton.addTarget(self, action: #selector(showProfile), for: .touchUpInside)
        profileButton.imageView?.contentMode = .scaleAspectFit
        profileButton.imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        let leftBarButton = UIBarButtonItem(customView: profileButton)
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    func getAllUsers() {
        do {
            let users = try context.fetch(Users.fetchRequest())
            usersData = users
            DispatchQueue.main.async {
                self.favoriteTableView.reloadData()
            }
        } catch _ {
            
        }
    }
    
    @objc private func showProfile() {
        print("profile button tap")
    }
    
    @objc private func showLocation(_ sender: Any) {
//        performSegue(withIdentifier: "ShowLocationModal", sender: self)
        let locationStoryboard = UIStoryboard(name: "Location", bundle: nil)
        let locationViewController = locationStoryboard.instantiateViewController(withIdentifier: "LocationViewController")
        
        if let presentationController = locationViewController.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()] /// change to [.medium(), .large()] for a half *and* full screen sheet
        }
        
        self.present(locationViewController, animated: true)
    }
    
    @IBAction private func filterButton(_ sender: UIButton) {
        let filterStoryboard = UIStoryboard(name: "Filter", bundle: nil)
        let filterViewController = filterStoryboard.instantiateViewController(withIdentifier: "FilterViewController")
        
        if let presentationController = filterViewController.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()] /// change to [.medium(), .large()] for a half *and* full screen sheet
        }
        
        self.present(filterViewController, animated: true)
    }
    
    @objc func deleteButton(_ sender: UIButton) {
        let restaurant = filteredData[sender.tag]
        print("tap to delete: " + restaurant.name!)
//        let user = Users(context: context)
//        let restaurant = filteredData[sender.tag]
//        filteredData = filteredData.filter({(r: Restaurants) -> Bool in
//            return r.name != restaurant.name
//        })
//        context.delete(restaurant)
//        user.restaurants = NSSet(array: filteredData)
//        do {
//            try context.save()
//            DispatchQueue.main.async {
//                self.favoriteTableView.reloadData()
//            }
//        } catch _ {
//        }
    }
    
    @objc func directionButton(_ sender: UIButton) {
        let restaurant = filteredData[sender.tag]
        print("tap to direction: " + restaurant.name!)
        OpenMapDirections.present(in: self, sourceView: sender)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let search = searchBarInstance.search
        filteredData = []
        filteredData = search(NSSet(array: favRestaurantsData), searchText)
        DispatchQueue.main.async {
            self.favoriteTableView.reloadData()
        }
    }
    
    func filterReload(rateFilter: [Double], priceFilter: [Int]) {
        filteredData = favRestaurantsData
        print(filteredData as Any)
//        if rateFilter.count > 0 && rateFilter.count < 5 {
//            filteredData = filteredData.filter({(r: Restaurants) -> Bool in
//                if rateFilter.count == 1 {
//                    return r.rating == rateFilter[0]
//                } else if rateFilter.count == 2 {
//                    return r.rating == rateFilter[0] || r.rating == rateFilter[1]
//                } else if rateFilter.count == 3 {
//                    return r.rating == rateFilter[0] || r.rating == rateFilter[1] || r.rating == rateFilter[2]
//                } else {
//                    return r.rating == rateFilter[0] || r.rating == rateFilter[1] || r.rating == rateFilter[2] || r.rating == rateFilter[3]
//                }
//            })
//        }
        
//        if priceFilter[0] > 0 {
//            filteredData = filteredData.filter({(r: Restaurants) -> Bool in
//                return Int(r.priceMin!)! >= priceFilter[0]
//            })
//        }
//
//        if priceFilter[1] > 0 {
//            filteredData = filteredData.filter({(r: Restaurants) -> Bool in
//                return Int(r.priceMax!)! <= priceFilter[1]
//            })
//        }
        
        
        print(rateFilter)
        print(priceFilter)
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let restaurant = filteredData[indexPath.row]
        print("tap to detail: " + restaurant.name!)
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favoriteCell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoriteTableViewCell
            
        let restaurant = filteredData[indexPath.row]
        favoriteCell.restaurantImageView.image = UIImage(data: restaurant.image!)
        favoriteCell.restaurantImageView.layer.cornerRadius = 7
        favoriteCell.restaurantNameLabel.text = restaurant.name
        favoriteCell.restaurantKecamatanLabel.text = restaurant.kecamatan
        favoriteCell.restaurantOpenHoursLabel.text = restaurant.openHours
        
        let imageAttachment = NSTextAttachment()
        let icon = UIImage(systemName: "clock")
        imageAttachment.image = icon?.maskWithColor(color: UIColor(red: 90/255, green: 141/255, blue: 38/255, alpha: 1))
        let imageOffsetY: CGFloat = -3.0
        imageAttachment.bounds = CGRect(x: -2, y: imageOffsetY, width: imageAttachment.image!.size.width * 0.7, height: imageAttachment.image!.size.height * 0.7)
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        let completeText = NSMutableAttributedString(string: "")
        completeText.append(attachmentString)
        favoriteCell.restaurantClockIcon.attributedText = completeText
        
        favoriteCell.deleteButton.layer.borderColor = UIColor(red: 90/255, green: 141/255, blue: 38/255, alpha: 1).cgColor
        
        favoriteCell.deleteButton.tag = indexPath.row;
        favoriteCell.directionButton.tag = indexPath.row;
        favoriteCell.deleteButton.addTarget(self, action: #selector(deleteButton(_:)), for: .touchUpInside)
        favoriteCell.directionButton.addTarget(self, action: #selector(directionButton(_:)), for: .touchUpInside)
        
        return favoriteCell
    }
}
