//
//  LoginViewController.swift
//  Mini_Challenge_2
//
//  Created by Wildan Budi on 29/06/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var signupButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        signupButton.layer.cornerRadius = 15
        signupButton.layer.borderColor = UIColor(red: 90/255, green: 141/255, blue: 38/255, alpha: 1).cgColor
        // Do any additional setup after loading the view.
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
