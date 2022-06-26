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
    var currentUser: Users!
    
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
        getUser()
        configureBarAtribute()
        // Collection View Layout
        collectionView.collectionViewLayout = createLayout()
        
        menuRestaurantData = (restaurantDetail.menus!.allObjects as! [Menus])
        
        connectControllerToData()
        
        // Filtered menus
        menus = menuRestaurantData.filter({(r: Menus) -> Bool in
            return r.image != nil
        })
    }
    
    
    // Navigation Bar Atribute 
    private func configureBarAtribute() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .done, target: self, action: #selector(addToFavorite(_ :)))
    }
    
    @objc func addToFavorite(_ sender: Any) {
        var newFavorites = currentUser.restaurants?.allObjects as! [Restaurants]
        newFavorites.append(restaurantDetail)
        currentUser.restaurants = NSSet(array: newFavorites)
        do {
            try context.save()
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .done, target: self, action: #selector(addToFavorite(_ :)))
        } catch _ {
        }
    }
    
    // Get Data from Restaurant
    func getUser() {
        currentUser = UsersModel.getUser()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    // Connect Controller to Database
    func connectControllerToData () {
        RestaurantLabel.text = restaurantDetail.name
        //RestaurantType.image = restaurantDetail
        PriceTagMin.text = restaurantDetail.priceMin
        PriceTagMax.text = restaurantDetail.priceMax
        RateTag.text = String(restaurantDetail.rating)
        OpenHourTag.text = restaurantDetail.openHours
        ContactTag.text = restaurantDetail.phone
        AddressTag.text = restaurantDetail.address
        AddressTag.lineBreakMode = NSLineBreakMode.byWordWrapping
        AddressTag.numberOfLines = 2
    }
    
    // Map Direction Function
    @IBAction func mapPressed(_ sender: Any) {
        locationButton.addTarget(self, action: #selector(askToOpenMap), for: .touchUpInside)
    }
    
    @IBAction func seeAllReviews (_ sender: UIButton) {
        performSegue(withIdentifier: "GoToReview", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "GoToReview") {
            let nav = segue.destination as! UINavigationController
            if let reviewVC = nav.topViewController as? ReviewViewController {
                reviewVC.restaurantData = restaurantDetail
            }
        }
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
