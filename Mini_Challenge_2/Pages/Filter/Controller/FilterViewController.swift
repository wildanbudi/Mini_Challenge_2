//
//  FilterViewController.swift
//  Mini_Challenge_2
//
//  Created by feedloop on 23/06/22.
//

import UIKit

class FilterViewController: UIViewController {
    @IBOutlet var star5Button: UIButton!
    @IBOutlet var star4Button: UIButton!
    @IBOutlet var star3Button: UIButton!
    @IBOutlet var star2Button: UIButton!
    @IBOutlet var star1Button: UIButton!
    @IBOutlet var fromTextField: UITextField!
    @IBOutlet var toTextField: UITextField!
    
    var rateFilter = [false, false, false, false, false]
    var fromPrice = 0
    var toPrice = 0
    var rateList: [Double]!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.star5Button.layer.borderColor = UIColor(red: 90/255, green: 141/255, blue: 38/255, alpha: 1).cgColor
        self.star4Button.layer.borderColor = UIColor(red: 90/255, green: 141/255, blue: 38/255, alpha: 1).cgColor
        self.star3Button.layer.borderColor = UIColor(red: 90/255, green: 141/255, blue: 38/255, alpha: 1).cgColor
        self.star2Button.layer.borderColor = UIColor(red: 90/255, green: 141/255, blue: 38/255, alpha: 1).cgColor
        self.star1Button.layer.borderColor = UIColor(red: 90/255, green: 141/255, blue: 38/255, alpha: 1).cgColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        fromPrice = Int(fromTextField.text ?? "0") ?? 0
        toPrice = Int(toTextField.text ?? "0") ?? 0
        
        rateList = rateFilter.enumerated().filter {
            $0.element == true
        }.map{Double($0.offset + 1)}
    }
    @IBAction private func star5ButtonTapped(_ sender: UIButton) {
        rateFilter[4] = !rateFilter[4]
        sender.backgroundColor = UIColor(red: 90/255, green: 141/255, blue: 38/255, alpha: 1)
        star5Button.tintColor = .white
    }
    @IBAction private func star4ButtonTapped(_ sender: UIButton) {
        rateFilter[3] = !rateFilter[3]
        star4Button.backgroundColor = UIColor(red: 90/255, green: 141/255, blue: 38/255, alpha: 1)
        star4Button.tintColor = .white
    }
    @IBAction private func star3ButtonTapped(_ sender: UIButton) {
        rateFilter[2] = !rateFilter[2]
        star3Button.backgroundColor = UIColor(red: 90/255, green: 141/255, blue: 38/255, alpha: 1)
        star3Button.tintColor = .white
    }
    @IBAction private func star2ButtonTapped(_ sender: UIButton) {
        rateFilter[1] = !rateFilter[1]
        star2Button.backgroundColor = UIColor(red: 90/255, green: 141/255, blue: 38/255, alpha: 1)
        star2Button.tintColor = .white
    }
    @IBAction private func star1ButtonTapped(_ sender: UIButton) {
        rateFilter[0] = !rateFilter[0]
        star1Button.backgroundColor = UIColor(red: 90/255, green: 141/255, blue: 38/255, alpha: 1)
        star1Button.tintColor = .white
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
