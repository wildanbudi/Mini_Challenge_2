//
//  ReviewViewController.swift
//  Mini_Challenge_2
//
//  Created by feedloop on 22/06/22.
//

import UIKit

class ReviewViewController: UIViewController, UITableViewDelegate {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var restaurantsData: [Restaurants]!
    var reviewsData: [Reviews]!
    
    @IBOutlet var reviewTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        getAllRestaurants()
        
        reviewTableView.delegate = self
        reviewTableView.dataSource = self

        let restaurant = restaurantsData.filter({(r: Restaurants) -> Bool in
            return r.name == "Formaggio Coffee and Resto"
        }).first ?? Restaurants(context: context)
        
        reviewsData = (restaurant.reviews!.allObjects as! [Reviews])
    }
    
    func getAllRestaurants() {
        do {
            restaurantsData = try context.fetch(Restaurants.fetchRequest())
            DispatchQueue.main.async {
                self.reviewTableView.reloadData()
            }
        } catch _ {
            
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

extension ReviewViewController: UITableViewDataSource {
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
        let reviewCell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewTableViewCell
        
        let review = reviewsData[indexPath.row]
        reviewCell.userImageView.image = UIImage(data: (review.user?.image)!)
        reviewCell.userImageView.layer.cornerRadius = reviewCell.userImageView.frame.width / 2;
        reviewCell.userImageView.layer.masksToBounds = true
        reviewCell.userImageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        reviewCell.userImageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        reviewCell.userNameLabel.text = review.user?.name
        reviewCell.userCommentLabel.text = review.comment
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let formattedDate = formatter.string(from: review.date!)
        
        reviewCell.reviewDateLabel.text = formattedDate
        if review.image != nil {
            reviewCell.reviewImageView.image = UIImage(data: review.image!)
            reviewCell.reviewImageView.layer.cornerRadius = 7
        } else {
            reviewCell.reviewImageView.isHidden = true
        }
        
        let userRates: [UIImageView] = [
            reviewCell.userRateIcon1, reviewCell.userRateIcon2, reviewCell.userRateIcon3, reviewCell.userRateIcon4, reviewCell.userRateIcon5
        ]
        let rateCount = 1...review.rate
        for n in rateCount {
            userRates[Int(n) - 1].image  = UIImage(systemName: "star.fill")
            userRates[Int(n) - 1].tintColor = UIColor(red: 255/255, green: 199/255, blue: 0/255, alpha: 1)
        }
        
        return reviewCell
    }
}

