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
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let locationManager = CLLocationManager()
    var restaurantModel: [Restaurants] = []
    var dataShow: [Restaurants] = []
    var currentData: [Restaurants] = []
    var restaurantData: NSSet!
    var distance: CLLocationDistance!
    var currentLocation: CLLocation!
    var detailData: Restaurants!
    let searchInstance = SearchBar()
    var isProfileShown : Bool = false
    var exploreFromPrice = 0
    var exploreToPrice = 0
    var exploreRateList: [Double]!
    var currentUser: Users!

    @IBOutlet weak var profileViewLeading: NSLayoutConstraint!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var backViewProfile: UIView!
    @IBOutlet weak var backView2: UIView!
    @IBOutlet weak var restaurantList: UITableView!
    @IBOutlet weak var username: UIButton!
    @IBOutlet weak var location: UIButton!
    @IBOutlet weak var filter: UIButton!
    @IBAction func backView2Tapped(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.backViewProfile.isHidden = true
            self.profileViewLeading.constant = -343
            self.view.layoutIfNeeded()
            self.backViewProfile.isHidden = true
            self.backView2.isHidden = true
        } completion: { (status) in
        }
        self.isProfileShown = false
        search.isHidden = false
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
        profileButton.frame = CGRect(x: 0, y: 5, width: 0, height: 30)
        let profileLabel = UILabel(frame: CGRect(x: 30, y: 5, width: 100, height: 20))// set position of label
        profileLabel.text = currentUser.name
        profileLabel.textColor = UIColor.black
        profileLabel.backgroundColor =   UIColor.clear
        profileButton.addSubview(profileLabel)
        profileButton.addTarget(self, action: #selector(showProfile), for: .touchUpInside)
        profileButton.imageView?.contentMode = .scaleAspectFit
        profileButton.imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        let leftBarButton = UIBarButtonItem(customView: profileButton)
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    @IBAction func backViewProfileTapped(_ sender: Any) {
    }
    @objc private func showProfile(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.profileViewLeading.constant = 0
            self.view.layoutIfNeeded()
            self.backViewProfile.isHidden = false
          self.backView2.isHidden = false
        } completion: { (status) in
        }
        self.isProfileShown = true
        search.isHidden = true
        self.navigationItem.setLeftBarButtonItems(nil, animated: true)
        self.navigationItem.setRightBarButtonItems(nil, animated: true)
    }
    @IBOutlet weak var segmentedType: UISegmentedControl!
    @IBAction func restoType(_ sender: Any) {
        switch segmentedType.selectedSegmentIndex
        {
        case 1:
            currentData = restaurantModel.filter({(r: Restaurants) -> Bool in
                return r.vegeResto == true
            })
            dataShow = currentData
            DispatchQueue.main.async {
                self.restaurantList.reloadData()
            }
        case 2:
            currentData = restaurantModel.filter({(r: Restaurants) -> Bool in
                return r.vegeResto == false && r.name != nil
            })
            dataShow = currentData
            DispatchQueue.main.async {
                self.restaurantList.reloadData()
            }
        default:
            currentData = restaurantModel.filter({(r: Restaurants) -> Bool in
                return r.name != nil
            })
            dataShow = currentData
            DispatchQueue.main.async {
                self.restaurantList.reloadData()
            }
        }
    }
    @IBOutlet weak var search: UISearchBar!
    @IBAction func filterButton(_ sender: Any) {
        let filterStoryboard = UIStoryboard(name: "Filter", bundle: nil)
        let filterViewController = filterStoryboard.instantiateViewController(withIdentifier: "FilterViewController")
        
        if let presentationController = filterViewController.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()] /// change to [.medium(), .large()] for a half *and* full screen sheet
        }
        
        let filterVC = filterViewController as! FilterViewController
        filterVC.fromPrice = exploreFromPrice
        filterVC.toPrice = exploreToPrice
        filterVC.rateList = exploreRateList
        self.present(filterViewController, animated: true)
    }
    @objc private func showLocation(_ sender: Any) {
        let locationStoryboard = UIStoryboard(name: "Location", bundle: nil)
        let locationViewController = locationStoryboard.instantiateViewController(withIdentifier: "LocationViewController")
        
        if let presentationController = locationViewController.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()] /// change to [.medium(), .large()] for a half *and* full screen sheet
        }
        
        self.present(locationViewController, animated: true)
    }
    
    private var beginPoint:CGFloat = 0.0
    private var difference:CGFloat = 0.0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      if isProfileShown{
           if let touch = touches.first{
              let location = touch.location(in: backViewProfile)
              beginPoint = location.x
          }
      }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
      if isProfileShown{
          if let touch = touches.first{
              let location = touch.location(in: backViewProfile)
              
              let differenceFromBeginPoint = beginPoint - location.x
              
              if (differenceFromBeginPoint>0 || differenceFromBeginPoint<343){
                  difference = differenceFromBeginPoint
                  self.profileViewLeading.constant = -differenceFromBeginPoint
              }
          }
      }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      if  isProfileShown{
          if difference>100{
              UIView.animate(withDuration: 0.1) {
                  self.profileViewLeading.constant = -343
              } completion: { (status) in
                  self.isProfileShown = false
                  self.backViewProfile.isHidden = true
                self.backView2.isHidden = true
                self.tabBarController?.tabBar.isHidden = false
              }
          }
          else{
              UIView.animate(withDuration: 0.1) {
                  self.profileViewLeading.constant = 0
              } completion: { (status) in
                  self.isProfileShown = true
                  self.backViewProfile.isHidden = false
                self.backView2.isHidden = false
                self.tabBarController?.tabBar.isHidden = true
              }
          }
      }
    }
    
    @IBAction func cancel(_ unwindSegue: UIStoryboardSegue) {}
    
    @IBAction func applyFilter(_ unwindSegue: UIStoryboardSegue) {
        guard let filterViewController = unwindSegue.source as? FilterViewController,
            case let fromPrice = filterViewController.fromPrice,
            case let toPrice = filterViewController.toPrice,
            case let rateList = filterViewController.rateList
            else {
                    return
            }
        
        dataShow = restaurantModel
        exploreRateList = rateList
        if rateList!.count > 0 && rateList!.count < 5 {
            dataShow = dataShow.filter({(r: Restaurants) -> Bool in
                if exploreRateList!.count == 1 {
                    return r.rating == exploreRateList![0]
                } else if exploreRateList!.count == 2 {
                    return r.rating == exploreRateList![0] || r.rating == exploreRateList![1]
                } else if exploreRateList!.count == 3 {
                    return r.rating == exploreRateList![0] || r.rating == exploreRateList![1] || r.rating == exploreRateList![2]
                } else {
                    return r.rating == exploreRateList![0] || r.rating == exploreRateList![1] || r.rating == exploreRateList![2] || r.rating == exploreRateList![3]
                }
            })
        }
        
        exploreFromPrice = fromPrice
        exploreToPrice = toPrice
        let priceFilter = [exploreFromPrice, exploreToPrice]
        if priceFilter[0] > 0 {
            dataShow = dataShow.filter({(r: Restaurants) -> Bool in
                return Int(r.priceMin!)! >= priceFilter[0]
            })
        }

        if priceFilter[1] > 0 {
            dataShow = dataShow.filter({(r: Restaurants) -> Bool in
                return Int(r.priceMax!)! <= priceFilter[1]
            })
        }
        DispatchQueue.main.async {
            self.restaurantList.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        username.isHidden = true
        location.isHidden = true
        if isProfileShown == false{
          backViewProfile.isHidden = true
          backView2.isHidden = true
        }else{
          backViewProfile.isHidden = false
          backView2.isHidden = false
        }
        self.view.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 255/255)
        search.delegate = self
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        registerCell()
        getAllItem()
        getUser()
        currentData = restaurantModel.filter({(r: Restaurants) -> Bool in
            return r.name != nil
        })
        dataShow = currentData
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
        profileLabel.text = currentUser.name
        profileLabel.textColor = UIColor.black
        profileLabel.backgroundColor =   UIColor.clear
        profileButton.addSubview(profileLabel)
        profileButton.addTarget(self, action: #selector(showProfile), for: .touchUpInside)
        profileButton.imageView?.contentMode = .scaleAspectFit
        profileButton.imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        let leftBarButton = UIBarButtonItem(customView: profileButton)
        self.navigationItem.leftBarButtonItem = leftBarButton
//        UILabel.appearance().font = UIFont(name: "SF Pro", size: 12)
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
    
    func getUser() {
        currentUser = UsersModel.getUser()
        
        DispatchQueue.main.async {
            self.restaurantList.reloadData()
        }
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

extension ExploreViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let search = searchInstance.search
        dataShow = search(NSSet(array: currentData), searchText)
        DispatchQueue.main.async {
            self.restaurantList.reloadData()
        }
    }
}

extension ExploreViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataShow.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as? RestaurantTableViewCell)!
        if dataShow[indexPath.row].image != nil {
            cell.restaurantImage.image = UIImage(data: dataShow[indexPath.row].image!)
        }
        if dataShow[indexPath.row].vegeResto {
            cell.restaurantType.image = UIImage(systemName: "leaf.fill")
        } else {
            cell.restaurantType.image = UIImage(systemName: "")
        }
        cell.restaurantImage.layer.cornerRadius = 7
        cell.name.text = dataShow[indexPath.row].name
        cell.location.text = dataShow[indexPath.row].kecamatan
        cell.rating.text = String(dataShow[indexPath.row].rating)
        cell.openStatus.text = "Open"
        let location = CLLocation(latitude: dataShow[indexPath.row].latitude, longitude: dataShow[indexPath.row].longitude)
        if currentLocation != nil {
            distance = currentLocation.distance(from: location)
            cell.distance.text = String(Int(distance/1000)) + "km"
        }

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailData = dataShow[indexPath.row]
        performSegue(withIdentifier: "GoToDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToDetail" {
            if let detail = segue.destination as? DetailViewController {
                detail.restaurantDetail = detailData
            }
        }
    }
    
}
