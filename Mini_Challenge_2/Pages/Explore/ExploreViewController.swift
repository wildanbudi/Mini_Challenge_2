//
//  ExploreViewController.swift
//  Mini_Challenge_2
//
//  Created by Wildan Budi on 14/06/22.
//

import UIKit
import CoreLocation
import MapKit

class ExploreViewController: UIViewController {
    
    var restaurantData: NSSet!
    var distance: CLLocationDistance!
    var currentLocation: CLLocation!

    @IBOutlet weak var restaurantList: UITableView!
    @IBOutlet weak var username: UIButton!
    @IBOutlet weak var location: UIButton!
    @IBOutlet weak var filter: UIButton!
    @IBAction func usernameButton(_ sender: Any) {
        performSegue(withIdentifier: "GoToProfile", sender: self)
    }
    @IBOutlet weak var segmentedType: UISegmentedControl!
    @IBAction func restoType(_ sender: Any) {
        switch segmentedType.selectedSegmentIndex
        {
        case 1:
            print("first")
        case 2:
            print("second")
        default:
            print("all")
        }
    }
    @IBOutlet weak var search: UISearchBar!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let locationManager = CLLocationManager()
    var restaurantModel: [Restaurants] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        username.setTitle("Username", for: .normal)
        username.setTitleColor(.black, for: .normal)
        location.setTitleColor(.gray, for: .normal)
        location.setTitle("Jakarta", for: .normal)
        registerCell()
        getAllItem()
        UILabel.appearance().font = UIFont(name: "SF Pro", size: 12)
        // Do any additional setup after loading the view.
    }
    
    func registerCell() {
        restaurantList.register(UINib(nibName: "RestaurantTableViewCell", bundle: nil), forCellReuseIdentifier: "restaurantCell")
    }
    
    func getAllItem() {
        do {
            restaurantModel = try context.fetch(Restaurants.fetchRequest())
            
            DispatchQueue.main.async {
                self.restaurantList.reloadData()
            }
        }
        catch{
            //error handling
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 125 : 125
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ExploreViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        let loc = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        currentLocation = loc
    }
    
    
}

//extension ExploreViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        <#code#>
//    }
//}

extension ExploreViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as? RestaurantTableViewCell)!
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.layer.cornerRadius = 15
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.gray.cgColor
        if restaurantModel[indexPath.row].image != nil {
            cell.restaurantImage.image = UIImage(data: restaurantModel[indexPath.row].image!)
        }
        cell.restaurantImage.layer.cornerRadius = 7
        cell.name.text = restaurantModel[indexPath.row].name
        cell.location.text = restaurantModel[indexPath.row].kecamatan
        cell.rating.text = String(restaurantModel[indexPath.row].rating)
        cell.openStatus.text = "Open"
        let location = CLLocation(latitude: restaurantModel[indexPath.row].latitude, longitude: restaurantModel[indexPath.row].longitude)
        if currentLocation != nil {
            distance = currentLocation.distance(from: location)
            cell.distance.text = String(Int(distance/1000)) + "km"
        }

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToDetail", sender: self)
    }
    
}
