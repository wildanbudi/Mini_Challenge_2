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
    var selectedRestaurant: Restaurants!
    var currentUser: Users!
    var isProfileShown : Bool = false
    var favFromPrice = 0
    var favToPrice = 0
    var favRateList: [Double]!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var favoriteTableView: UITableView!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var profileViewLeading: NSLayoutConstraint!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var backViewProfile: UIView!
    @IBOutlet weak var backView2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isProfileShown == false {
          backViewProfile.isHidden = true
          backView2.isHidden = true
        } else {
          backViewProfile.isHidden = false
          backView2.isHidden = false
        }
        getUser()
        
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        self.favoriteTableView.keyboardDismissMode = .onDrag
        
        searchBar.delegate = self
        
        setNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getUser()
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
          setNavBar()
      }
    }
    
    func getUser() {
        currentUser = UsersModel.getUser()
        
        favRestaurantsData = (currentUser.restaurants!.allObjects as! [Restaurants])
        filteredData = favRestaurantsData
        DispatchQueue.main.async {
            self.favoriteTableView.reloadData()
        }
    }
    
    func setNavBar() {
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
    }
    
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
        setNavBar()
    }

    @IBAction func backViewProfileTapped(_ sender: Any) {}
    
    @objc private func showProfile() {
        self.searchBar.endEditing(true)
        UIView.animate(withDuration: 0.3) {
            self.profileViewLeading.constant = 0
            self.view.layoutIfNeeded()
            self.backViewProfile.isHidden = false
            self.backView2.isHidden = false
         } completion: { (status) in }
         self.isProfileShown = true
        self.navigationItem.setLeftBarButtonItems(nil, animated: true)
        self.navigationItem.setRightBarButtonItems(nil, animated: true)
    }
    
    
    @objc private func showLocation(_ sender: Any) {
        self.searchBar.endEditing(true)
        let locationStoryboard = UIStoryboard(name: "Location", bundle: nil)
        let locationViewController = locationStoryboard.instantiateViewController(withIdentifier: "LocationViewController")
        
        if let presentationController = locationViewController.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()] /// change to [.medium(), .large()] for a half *and* full screen sheet
        }
        
        self.present(locationViewController, animated: true)
    }
    
    @IBAction private func filterButton(_ sender: UIButton) {
        self.searchBar.endEditing(true)
        let filterStoryboard = UIStoryboard(name: "Filter", bundle: nil)
        let filterViewController = filterStoryboard.instantiateViewController(withIdentifier: "FilterViewController")
        
        if let presentationController = filterViewController.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()] /// change to [.medium(), .large()] for a half *and* full screen sheet
        }
        
        let filterVC = filterViewController as! FilterViewController
        filterVC.fromPrice = favFromPrice
        filterVC.toPrice = favToPrice
        filterVC.rateList = favRateList
        self.present(filterVC, animated: true)
    }
    
    @objc func deleteButton(_ sender: UIButton) {
        let restaurant = filteredData[sender.tag]
        
        filteredData = filteredData.filter({(r: Restaurants) -> Bool in
            return r.name != restaurant.name
        })
        currentUser.restaurants = NSSet(array: filteredData)
        do {
            try context.save()
            getUser()
            DispatchQueue.main.async {
                self.favoriteTableView.reloadData()
            }
        } catch _ {
        }
    }
    
    @objc func directionButton(_ sender: UIButton) {
        let restaurant = filteredData[sender.tag]
        OpenMapsLocation.present(in: self, sourceView: sender, restaurant: restaurant)
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
        
        filteredData = favRestaurantsData
        favRateList = rateList
        if favRateList!.count > 0 && favRateList!.count < 5 {
            filteredData = filteredData.filter({(r: Restaurants) -> Bool in
                if favRateList!.count == 1 {
                    return r.rating == favRateList![0]
                } else if favRateList!.count == 2 {
                    return r.rating == favRateList![0] || r.rating == favRateList![1]
                } else if favRateList!.count == 3 {
                    return r.rating == favRateList![0] || r.rating == favRateList![1] || r.rating == favRateList![2]
                } else {
                    return r.rating == favRateList![0] || r.rating == favRateList![1] || r.rating == favRateList![2] || r.rating == favRateList![3]
                }
            })
        }
        
        favFromPrice = fromPrice
        favToPrice = toPrice
        let priceFilter = [favFromPrice, favToPrice]
        if priceFilter[0] > 0 {
            filteredData = filteredData.filter({(r: Restaurants) -> Bool in
                return Int(r.priceMin!)! >= priceFilter[0]
            })
        }

        if priceFilter[1] > 0 {
            filteredData = filteredData.filter({(r: Restaurants) -> Bool in
                return Int(r.priceMax!)! <= priceFilter[1]
            })
        }
        DispatchQueue.main.async {
            self.favoriteTableView.reloadData()
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let search = searchBarInstance.search
        filteredData = []
        filteredData = search(NSSet(array: favRestaurantsData), searchText)
        DispatchQueue.main.async {
            self.favoriteTableView.reloadData()
        }
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRestaurant = filteredData[indexPath.row]
        performSegue(withIdentifier: "GoToDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "GoToDetail") {
            if let detailVC = segue.destination as? DetailViewController {
                detailVC.restaurantDetail = selectedRestaurant
            }
        }
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredData.count == 0 {
            let messageImage = UIImageView()
            messageImage.translatesAutoresizingMaskIntoConstraints = false
            messageImage.heightAnchor.constraint(equalToConstant: self.view.frame.width/1.65).isActive = true
            messageImage.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
            messageImage.image = UIImage(named: "Illust_Restaurant Not Found")
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.width))
            
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            messageLabel.text = "Oh no! We cannot find the restaurant"
            messageLabel.textColor = UIColor(red: 174/255, green: 174/255, blue: 178/255, alpha: 1)
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.font = UIFont(name: "SFPro", size: 17)
            messageLabel.sizeToFit()
            
            messageImage.addSubview(messageLabel)
            messageLabel.centerXAnchor.constraint(equalTo: messageImage.centerXAnchor).isActive = true
            messageLabel.heightAnchor.constraint(equalToConstant: 520).isActive = true
            
            favoriteTableView.backgroundView = messageImage
            favoriteTableView.separatorStyle = .none
        } else {
            favoriteTableView.backgroundView = nil
            favoriteTableView.separatorStyle = .singleLine
        }

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
