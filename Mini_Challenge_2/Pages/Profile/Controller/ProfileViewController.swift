//
//  ProfileViewController.swift
//  Mini_Challenge_2
//
//  Created by Levina Niolana on 21/06/22.
//

import UIKit

class ProfileViewController: UIViewController {

  @IBOutlet weak var profileBackground: UIImageView!
  @IBOutlet weak var profilePic: UIImageView!
  
  @IBOutlet weak var signInUpBtn: UIButton!
  
  @IBOutlet weak var usernameTitle: UILabel!
  @IBOutlet weak var usernameLbl: UILabel!
  @IBOutlet weak var username: UILabel!
  @IBOutlet weak var emailLbl: UILabel!
  @IBOutlet weak var email: UILabel!
  
  @IBOutlet weak var signOutBtn: UIButton!
  
  var isUserSignedIn : Bool = true
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      setUp()

    }
  
  @IBAction func signOutTapped(_ sender: Any) {
    // Create Alert
    let confirmationMessage = UIAlertController(title: "Sign Out", message: "Are you sure want to sign out?", preferredStyle: .alert)
    
    // Create OK button with action handler
    let yes = UIAlertAction(title: "Yes", style: .default, handler: {_ in
    })
    // Create Cancel button with action handlder
    let cancel = UIAlertAction(title: "Cancel", style: .cancel) {_ in
    }
    
    //color
    confirmationMessage.view.tintColor = UIColor(named: "Green")
    
    //Add OK and Cancel button to an Alert object
    confirmationMessage.addAction(yes)
    confirmationMessage.addAction(cancel)
    // Present alert message to user
    self.present(confirmationMessage, animated: true, completion: nil)
  }
  
  
  @IBAction func SignInUpTapped(_ sender: UIButton) {
  }
  
  func setUp(){
    //profile background
    profileBackground.image = UIImage(named: "Profile_Login")
    
    //check is user signed in or not
    if isUserSignedIn == false{
      //profile pic
      profilePic.image = UIImage(named: "Default_Profile_Pic")
      profilePic.contentMode = .scaleAspectFill
      profilePic.layer.cornerRadius = profilePic.frame.size.width/2
      
      //show sign in / sign up
      signInUpBtn.isHidden = false
      
      //hide attribute
      usernameTitle.isHidden = true
      usernameLbl.isHidden = true
      username.isHidden = true
      emailLbl.isHidden = true
      email.isHidden = true
      signOutBtn.isHidden = true
      
    }else{
      //profile pic
      profilePic.image = UIImage(named: "Default_Profile_Pic")
      profilePic.contentMode = .scaleAspectFill
      profilePic.layer.cornerRadius = profilePic.frame.size.width/2
      
      //hide sign in / sign up
      signInUpBtn.isHidden = true
      
      //get data from core data
      
      //usernameTitle
      usernameTitle.text = "Vegeta Doe"
      
      //username
      username.text = "Vegeta Doe"
      
      //email
      email.text = "vdoe@bsd.idserve.net"
    }

  }
}
