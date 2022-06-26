//
//  RestaurantTableViewCell.swift
//  Mini_Challenge_2
//
//  Created by Wildan Budi on 16/06/22.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var openStatus: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var restaurantType: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.white.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
