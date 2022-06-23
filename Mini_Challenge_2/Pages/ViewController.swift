//
//  ViewController.swift
//  Mini_Challenge_2
//
//  Created by Wildan Budi on 11/06/22.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func FavoriteButton(_ sender: UIButton) {
        performSegue(withIdentifier: "GoToFavoriteVC", sender: self)
    }
    
    @IBAction func ReviewButton(_ sender: UIButton) {
        performSegue(withIdentifier: "GoToReviewVC", sender: self)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "GoToFavoriteVC" {
//            guard let vc = segue.destination as? FavoriteViewController else { return }
//            vc.modalPresentationStyle = .fullScreen
//
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }


}

