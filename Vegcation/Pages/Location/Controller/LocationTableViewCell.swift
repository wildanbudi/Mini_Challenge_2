//
//  LocationTableViewCell.swift
//  Mini_Challenge_2
//
//  Created by feedloop on 21/06/22.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var locationButton: UIButton!
    @IBAction func locationButtonTap(_ sender: UIButton) {
        LocationViewController().turnOnLocation()
        locationButton.isHidden = true
        label1.text = "Current Location:"
        label2.text = "Tangerang"
    }
}
