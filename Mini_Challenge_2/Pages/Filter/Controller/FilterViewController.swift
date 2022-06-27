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
    var rateList: [Double]! = []
    var vegeGreen = UIColor(red: 90/255, green: 141/255, blue: 38/255, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (rateList != nil) {
            for n in rateList {
                rateFilter[Int(n) - 1] = true
            }
        }
        fromTextField.text = String(fromPrice)
        toTextField.text = String(toPrice)
        
        let rateButtons = [self.star1Button, self.star2Button, self.star3Button, self.star4Button, self.star5Button]
        for i in 0...4 {
            rateButtons[i]!.layer.borderColor = vegeGreen.cgColor
            rateButtons[i]!.setTitle("\(i+1) Star", for: .normal)
            rateButtons[i]!.titleLabel?.font = .systemFont(ofSize: 17.0, weight: .bold)
            if rateFilter[i] {
                rateButtons[i]!.setImage(UIImage(systemName: "star.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
                rateButtons[i]!.backgroundColor = UIColor(red: 90/255, green: 141/255, blue: 38/255, alpha: 1)
                rateButtons[i]!.setTitleColor(.white, for: .normal)
            } else {
                rateButtons[i]!.setImage(UIImage(systemName: "star.fill")?.withTintColor(vegeGreen, renderingMode: .alwaysOriginal), for: .normal)
                rateButtons[i]!.setTitleColor(vegeGreen, for: .normal)
                rateButtons[i]!.backgroundColor = .white
            }
        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        let rateButtons = [self.star1Button, self.star2Button, self.star3Button, self.star4Button, self.star5Button]
//        for i in 0...4 {
//            rateButtons[i]!.layer.borderColor = vegeGreen.cgColor
//            rateButtons[i]!.setTitle("\(i+1) Star", for: .normal)
//            rateButtons[i]!.titleLabel?.font = .systemFont(ofSize: 17.0, weight: .bold)
//            if rateFilter[i] {
//                rateButtons[i]!.setImage(UIImage(systemName: "star.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
//                rateButtons[i]!.backgroundColor = UIColor(red: 90/255, green: 141/255, blue: 38/255, alpha: 1)
//                rateButtons[i]!.setTitleColor(.white, for: .normal)
//            } else {
//                rateButtons[i]!.setImage(UIImage(systemName: "star.fill")?.withTintColor(vegeGreen, renderingMode: .alwaysOriginal), for: .normal)
//                rateButtons[i]!.setTitleColor(vegeGreen, for: .normal)
//                rateButtons[i]!.backgroundColor = .white
//            }
//        }
//
//        fromTextField.text = String(fromPrice)
//        toTextField.text = String(toPrice)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        fromPrice = Int(fromTextField.text ?? "0") ?? 0
        toPrice = Int(toTextField.text ?? "0") ?? 0

        rateList = rateFilter.enumerated().filter {
            $0.element == true
        }.map{Double($0.offset + 1)}
    }
    
    @IBAction private func star5ButtonTapped(_ sender: UIButton) {
        rateFilter[4] = !rateFilter[4]
        if rateFilter[4] {
            star5Button.setImage(UIImage(systemName: "star.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
            star5Button.backgroundColor = UIColor(red: 90/255, green: 141/255, blue: 38/255, alpha: 1)
            star5Button.setTitleColor(.white, for: .normal)
        } else {
            star5Button.setImage(UIImage(systemName: "star.fill")?.withTintColor(vegeGreen, renderingMode: .alwaysOriginal), for: .normal)
            star5Button.setTitleColor(vegeGreen, for: .normal)
            star5Button.backgroundColor = .white
        }
    }
    @IBAction private func star4ButtonTapped(_ sender: UIButton) {
        rateFilter[3] = !rateFilter[3]
        if rateFilter[3] {
            star4Button.setImage(UIImage(systemName: "star.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
            star4Button.backgroundColor = UIColor(red: 90/255, green: 141/255, blue: 38/255, alpha: 1)
            star4Button.setTitleColor(.white, for: .normal)
        } else {
            star4Button.setImage(UIImage(systemName: "star.fill")?.withTintColor(vegeGreen, renderingMode: .alwaysOriginal), for: .normal)
            star4Button.setTitleColor(vegeGreen, for: .normal)
            star4Button.backgroundColor = .white
        }
    }
    @IBAction private func star3ButtonTapped(_ sender: UIButton) {
        rateFilter[2] = !rateFilter[2]
        if rateFilter[2] {
            star3Button.setImage(UIImage(systemName: "star.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
            star3Button.backgroundColor = UIColor(red: 90/255, green: 141/255, blue: 38/255, alpha: 1)
            star3Button.setTitleColor(.white, for: .normal)
        } else {
            star3Button.setImage(UIImage(systemName: "star.fill")?.withTintColor(vegeGreen, renderingMode: .alwaysOriginal), for: .normal)
            star3Button.setTitleColor(vegeGreen, for: .normal)
            star3Button.backgroundColor = .white
        }
    }
    @IBAction private func star2ButtonTapped(_ sender: UIButton) {
        rateFilter[1] = !rateFilter[0]
        if rateFilter[1] {
            star2Button.setImage(UIImage(systemName: "star.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
            star2Button.backgroundColor = UIColor(red: 90/255, green: 141/255, blue: 38/255, alpha: 1)
            star2Button.setTitleColor(.white, for: .normal)
        } else {
            star2Button.setImage(UIImage(systemName: "star.fill")?.withTintColor(vegeGreen, renderingMode: .alwaysOriginal), for: .normal)
            star2Button.setTitleColor(vegeGreen, for: .normal)
            star2Button.backgroundColor = .white
        }
    }
    @IBAction private func star1ButtonTapped(_ sender: UIButton) {
        rateFilter[0] = !rateFilter[0]
        if rateFilter[0] {
            star1Button.setImage(UIImage(systemName: "star.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
            star1Button.backgroundColor = UIColor(red: 90/255, green: 141/255, blue: 38/255, alpha: 1)
            star1Button.setTitleColor(.white, for: .normal)
        } else {
            star1Button.setImage(UIImage(systemName: "star.fill")?.withTintColor(vegeGreen, renderingMode: .alwaysOriginal), for: .normal)
            star1Button.setTitleColor(vegeGreen, for: .normal)
            star1Button.backgroundColor = .white
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

extension UIButton{

    func setImageTintColor(_ color: UIColor) {
        let tintedImage = self.imageView?.image?.withRenderingMode(.alwaysTemplate)
        self.setImage(tintedImage, for: .normal)
        self.tintColor = color
    }

}
