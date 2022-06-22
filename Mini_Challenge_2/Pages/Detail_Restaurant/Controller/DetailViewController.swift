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
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var RestaurantLabel: UILabel!
    @IBOutlet weak var RestaurantType: UIImageView!
    @IBOutlet weak var PriceTag: UILabel!
    @IBOutlet weak var RateTag: UILabel!
    @IBOutlet weak var OpenHourTag: UILabel!
    @IBOutlet weak var ContactTag: UILabel!
    @IBOutlet weak var AddressTag: UILabel!
    @IBOutlet weak var MapsImageButton: UIButton!
    
    
  //  private let sections = MockData.shared.pageData
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Details"
        configureBarAtribute()
        
        // Collection View Layout
        //collectionView.collectionViewLayout = createLayout()
        
        getAllRestaurant()
        let restaurant = restaurantData.filter({(r: Restaurants) -> Bool in
            return r.name == "Kayu-Kayu Restaurant"
        }).first ?? Restaurants(context: context)
        menuRestaurantData = (restaurant.menus!.allObjects as! [Menus])
        
        //filtered menus
        menus = menuRestaurantData.filter({(r: Menus) -> Bool in
            return r.image != nil
        })
    }
    
    
    // Navigation Bar Atribute 
    private func configureBarAtribute() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .done, target: self, action: nil)
    }
    
    
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
    
    //
    
    
    @IBAction func mapPressed(_ sender: Any) {
        locationButton.addTarget(self, action: #selector(askToOpenMap), for: .touchUpInside)
    }
    
    private func mapsLayout() -> UIButton {
        _ = UIImage(named: "Formaggio 1 - Caesar Salad") as UIImage?
        
        MapsImageButton.imageView?.contentMode = .scaleAspectFit
        return MapsImageButton
    }
    
//    private func createLayout() -> UICollectionViewCompositionalLayout {
//        UICollectionViewCompositionalLayout {[weak self] sectionIndex, layoutEnvironment in
//            guard let self = self else {return nil}
//                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
//                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.9)), subitems: [item])
//                let section = NSCollectionLayoutSection(group: group)
//                section.orthogonalScrollingBehavior = .groupPagingCentered
//                section.interGroupSpacing = 10
//                section.contentInsets = .init(top:0, leading: 10, bottom:0, trailing:10)
//                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
//                section.supplementariesFollowContentInsets = false
//                }
//    }
//}
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
    @IBAction func RatePressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToRate", sender: self)
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return sections.count
//    }
//
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PortraitCollectionViewCell", for: indexPath) as! PortraitCollectionViewCell
//            cell.setup(items[indexPath.row])
//            return cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PortraitCollectionViewCell", for: indexPath) as! PortraitCollectionViewCell
        let menu = menus[indexPath.row]
        cell.cellImageView.image = UIImage(data: menu.image!)

        return cell
    }
    
    @objc func askToOpenMap() {
        OpenMapDirections.present(in: self, sourceView: locationButton)
    }
    
    
}
