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
    var favRestaurantsData: NSSet!
    var filteredData: [Restaurants]!
    let searchBarInstance = SearchBar()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var favoriteTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllUsers()
        
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        
        searchBar.delegate = self
//        tableView.frame = view.bounds
//        view.addSubview(favoriteTable)
        
        
        let user = usersData.filter({(r: Users) -> Bool in
            return r.name == "Vegeta Doe"
        }).first ?? Users(context: context)
        
        favRestaurantsData = user.restaurants
        filteredData = (favRestaurantsData.allObjects as! [Restaurants])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Jakarta", image: UIImage(systemName: "location"))
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
    
    @objc private func didTapLocation() {
        print("tap")
    }
    
    @objc func filterButton() {
        print("filter button tap")
    }
    
    @objc func deleteButton(_ sender: UIButton) {
        let restaurant = filteredData[sender.tag]
        print("tap to delete: " + restaurant.name!)
    }
    
    @objc func directionButton(_ sender: UIButton) {
        let restaurant = filteredData[sender.tag]
        print("tap to direction: " + restaurant.name!)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let search = searchBarInstance.search
        filteredData = []
        filteredData = search(favRestaurantsData, searchText)
        DispatchQueue.main.async {
            self.favoriteTableView.reloadData()
        }
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
            
        let restaurant = (favRestaurantsData.allObjects as! [Restaurants])[indexPath.row]
        favoriteCell.restaurantImageView.loadFrom(URLAddress: restaurant.imageUrl!)
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
