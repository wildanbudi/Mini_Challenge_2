//
//  AddReviewViewController.swift
//  Mini_Challenge_2
//
//  Created by Finn Christoffer Kurniawan on 20/06/22.
//

import UIKit

class AddReviewViewController : UIViewController {
    @IBOutlet weak var ratingStackView: RatingController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Rate & Review"
        
        configureItems()
    }
//    @IBAction func HowManyButtonClicked(_ sender: Any) {
//        print(ratingStackView.starsRating)
//    }
    
    private func configureItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .done, target: self, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: nil)
    }
}
