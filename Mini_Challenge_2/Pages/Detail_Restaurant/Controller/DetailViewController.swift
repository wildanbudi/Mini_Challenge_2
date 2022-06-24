//
//  ViewController.swift
//  MultiSectionCompositionalLayout
//
//  Created by Emmanuel Okwara on 15.05.22.
//

import UIKit

class DetailViewController: UIViewController {
    
    var restaurantData: [Restaurants]!
    var menuRestaurantData: [Menus]!
    var menus: [Menus]!
    var restaurantDetail: Restaurants!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var RestaurantLabel: UILabel!
    @IBOutlet weak var RestaurantType: UIImageView!
    @IBOutlet weak var PriceTagMin: UILabel!
    @IBOutlet weak var RateTag: UILabel!
    @IBOutlet weak var OpenHourTag: UILabel!
    @IBOutlet weak var ContactTag: UILabel!
    @IBOutlet weak var AddressTag: UILabel!
    @IBOutlet weak var MapsImageButton: UIButton!
    @IBOutlet weak var PriceTagMax: UILabel!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure Bar Atribute
        title = "Details"
        configureBarAtribute()
        
        // Collection View Layout
        collectionView.collectionViewLayout = createLayout()
        
        getAllRestaurant()
        let restaurant = restaurantData.filter({(r: Restaurants) -> Bool in
            return r.name == "Che En Vegetarian"
        }).first ?? Restaurants(context: context)
        menuRestaurantData = (restaurant.menus!.allObjects as! [Menus])
        
        // Data Restaurant from protocol
        restaurantDetail = restaurant
        connectControllerToData()
        
        // Filtered menus
        menus = menuRestaurantData.filter({(r: Menus) -> Bool in
            return r.image != nil
        })
    }
    
    
    // Navigation Bar Atribute 
    private func configureBarAtribute() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .done, target: self, action: nil)
    }
    
    // Get Data from Restaurant
    func getAllRestaurant() {
        do {
            let restaurants = try context.fetch(Restaurants.fetchRequest())
            restaurantData = restaurants
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } catch _ {
            
        }
    }
    
    // Connect Controller to Database
    func connectControllerToData () {
        let imgMap = UIImage(data: restaurantDetail.imageMap! )
        RestaurantLabel.text = restaurantDetail.name
        RestaurantType.image = UIImage(data: restaurantDetail.image!)
        PriceTagMin.text = restaurantDetail.priceMin
        PriceTagMax.text = restaurantDetail.priceMax
        RateTag.text = String(restaurantDetail.rating)
        OpenHourTag.text = restaurantDetail.openHours
        ContactTag.text = restaurantDetail.phone
        AddressTag.text = restaurantDetail.address
        AddressTag.lineBreakMode = NSLineBreakMode.byWordWrapping
        AddressTag.numberOfLines = 2
        MapsImageButton.setImage(imgMap, for: .normal)
        MapsImageButton.layer.cornerRadius = 15
        MapsImageButton.clipsToBounds = true
    }
    
    // Map Direction Function
    @IBAction func mapPressed(_ sender: Any) {
        locationButton.addTarget(self, action: #selector(askToOpenMap), for: .touchUpInside)
    }
    
    // Layout Carousel
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(1)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.interGroupSpacing = 13
                section.contentInsets = .init(top:0, leading: 0, bottom:0, trailing:0)
                section.supplementariesFollowContentInsets = false
            return section
                }
    }
    
    
    // Function to Add Rate&Review
    @IBAction func RatePressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToRate", sender: self)
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return sections.count
//    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PortraitCollectionViewCell", for: indexPath) as! PortraitCollectionViewCell
        let menu = menus[indexPath.row]
        cell.cellImageView.image = UIImage(data: menu.image!)
        return cell
    }
    
    @objc func askToOpenMap() {
        OpenMapDirections.present(in: self, sourceView: locationButton)
    }
}
