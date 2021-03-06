//
//  ViewController.swift
//  MultiSectionCompositionalLayout
//
//  Created by Emmanuel Okwara on 15.05.22.
//

import UIKit

class DetailViewController: UIViewController,UITableViewDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var restaurantData: [Restaurants]!
    var menuRestaurantData: [Menus]!
    var menus: [Menus]!
    var restaurantDetail: Restaurants!
    var currentUser: Users!
    var reviewsData: [Reviews]!
    
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var DetailReviewTableView: UITableView!
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configure Bar Atribute
        title = "Details"
        getUser()
        configureBarAtribute()
        // Collection View Layout
        collectionView.collectionViewLayout = createLayout()
        
        menuRestaurantData = (restaurantDetail.menus!.allObjects as! [Menus])
        
        DetailReviewTableView.delegate = self
        DetailReviewTableView.dataSource = self
        
        reviewsData = (restaurantDetail.reviews!.allObjects as! [Reviews])
        
        // Data Restaurant from protocol
//        restaurantDetail = restaurant
        connectControllerToData()
        
        // Filtered menus
        menus = menuRestaurantData.filter({(r: Menus) -> Bool in
            return r.image != nil
        })
    }
    
    
    // Navigation Bar Atribute 
    private func configureBarAtribute() {
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
    
    func formatPointsMin() ->String{
        let num = Double(restaurantDetail.priceMin!)!
        let thousandNum = num/1000
        let millionNum = num/1000000
        if num >= 1000 && num < 1000000{
            if(floor(thousandNum) == thousandNum){
                return("\(Int(thousandNum))k")
            }
            return("\(thousandNum)k")
        }
        if num > 1000000{
            if(floor(millionNum) == millionNum){
                return("\(Int(thousandNum))k")
            }
            return ("\(millionNum)M")
        }
        else{
            if(floor(num) == num){
                return ("\(Int(num))")
            }
            return ("\(num)")
        }
    }
    
    func formatPointsMax() ->String{
        let num = Double(restaurantDetail.priceMax!)!
        let thousandNum = num/1000
        let millionNum = num/1000000
        if num >= 1000 && num < 1000000{
            if(floor(thousandNum) == thousandNum){
                return("\(Int(thousandNum))k")
            }
            return("\(thousandNum)k")
        }
        if num > 1000000{
            if(floor(millionNum) == millionNum){
                return("\(Int(thousandNum))k")
            }
            return ("\(millionNum)M")
        }
        else{
            if(floor(num) == num){
                return ("\(Int(num))")
            }
            return ("\(num)")
        }
    }
    
    // Connect Controller to Database
    func connectControllerToData () {
        let imgMap = UIImage(data: restaurantDetail.imageMap! )
        RestaurantLabel.text = restaurantDetail.name
        if restaurantDetail.vegeResto == false {
            RestaurantType.isHidden = true
        }else{
            RestaurantType.isHidden = false
        }
        pageController.isHidden = true
        PriceTagMin.text = formatPointsMin()
        PriceTagMax.text = formatPointsMax()
        RateTag.text = String(restaurantDetail.rating)
        OpenHourTag.text = restaurantDetail.openHours
        ContactTag.text = restaurantDetail.phone
        AddressTag.text = restaurantDetail.address
        AddressTag.lineBreakMode = NSLineBreakMode.byWordWrapping
        AddressTag.numberOfLines = 2
        MapsImageButton.setImage(imgMap, for: .normal)
        MapsImageButton.layer.cornerRadius = 15
        MapsImageButton.clipsToBounds = true
        MapsImageButton.imageView?.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
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
                section.interGroupSpacing = 10
                section.contentInsets = .init(top:0, leading: 0, bottom:0, trailing:0)
                section.supplementariesFollowContentInsets = false
            return section
                }
    }
    
    
    // Function to Add Rate&Review
    @IBAction func RatePressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToRate", sender: self)
    }
    
    @IBAction func ReviewAll(_ sender: UIButton) {
        performSegue(withIdentifier: "goToReviewAll", sender: self)
    }
    
}



extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource,UITableViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return menus.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PortraitCollectionViewCell", for: indexPath) as! PortraitCollectionViewCell
        let menu = menus[indexPath.row]
        cell.cellImageView.image = UIImage(data: menu.image!)
        return cell
    }
  
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: self.collectionView.contentOffset, size: self.collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = self.collectionView.indexPathForItem(at: visiblePoint) {
            self.pageController.currentPage = visibleIndexPath.row
        }
    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//       let visibleRect = CGRect(origin: self.collectionView.contentOffset, size: self.collectionView.bounds.size)
//       let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
//       if let visibleIndexPath = self.collectionView.indexPathForItem(at: visiblePoint) {
//                self.pageController.currentPage = visibleIndexPath.row
//       }
//    }
    
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return reviewsData.count
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 172
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let DetailReviewCell = tableView.dequeueReusableCell(withIdentifier: "DetailReviewCell", for: indexPath) as! DetailReviewTableViewCell
            
            let review = reviewsData[indexPath.row]
            DetailReviewCell.DetailUserImageView.image = UIImage(data: (review.user?.image)!)
            DetailReviewCell.DetailUserImageView.layer.cornerRadius = DetailReviewCell.DetailUserImageView.frame.width / 2;
            DetailReviewCell.DetailUserImageView.layer.masksToBounds = true
            DetailReviewCell.DetailUserImageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            DetailReviewCell.DetailUserImageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
            DetailReviewCell.DetailUserNameLabel.text = review.user?.name
            DetailReviewCell.DetailUserCommentLabel.text = review.comment
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            let formattedDate = formatter.string(from: review.date!)
            
            DetailReviewCell.DetailReviewDataLabel.text = formattedDate
            if review.image != nil {
                DetailReviewCell.DetailReviewImageView.image = UIImage(data: review.image!)
                DetailReviewCell.DetailReviewImageView.layer.cornerRadius = 7
            } else {
                DetailReviewCell.DetailReviewImageView.isHidden = true
            }
            
            let userRates: [UIImageView] = [
                DetailReviewCell.DetailUserRateIcon1, DetailReviewCell.DetailUserRateIcon2, DetailReviewCell.DetailUserRateIcon3, DetailReviewCell.DetailUserRateIcon4, DetailReviewCell.DetailUserRateIcon5
            ]
            let rateCount = 1...review.rate
            for n in rateCount {
                userRates[Int(n) - 1].image  = UIImage(systemName: "star.fill")
                userRates[Int(n) - 1].tintColor = UIColor(red: 255/255, green: 199/255, blue: 0/255, alpha: 1)
            }
            
            return DetailReviewCell
        }
    

    
    @objc func askToOpenMap(_ sender:UIButton) {
        OpenMapsLocation.present(in: self, sourceView: sender, restaurant: restaurantDetail)
    }
    
    @IBAction func pageControllerAction(_ sender: UIPageControl) {
           self.collectionView.scrollToItem(at: IndexPath(row: sender.currentPage, section: 0), at: .centeredHorizontally, animated: true)
    }
}

