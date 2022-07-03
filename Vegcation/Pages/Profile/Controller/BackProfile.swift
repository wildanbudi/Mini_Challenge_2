//
//  BackProfile.swift
//  Mini_Challenge_2
//
//  Created by Levina Niolana on 21/06/22.
//

import UIKit

class BackProfile: UIViewController {

  @IBOutlet weak var profileView: UIView!
  @IBOutlet weak var profileViewLeading: NSLayoutConstraint!
  
  @IBOutlet weak var backViewProfile: UIView!
  @IBOutlet weak var backView2: UIView!
  
  var isProfileShown : Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if isProfileShown == false{
      backViewProfile.isHidden = true
      backView2.isHidden = true
    }else{
      backViewProfile.isHidden = false
      backView2.isHidden = false
    }
  }
  
  @IBAction func buttonTapped(_ sender: Any) {
    self.tabBarController?.tabBar.isHidden = true
    
    UIView.animate(withDuration: 0.3) {
        self.profileViewLeading.constant = 0
        self.view.layoutIfNeeded()
        self.backViewProfile.isHidden = false
      self.backView2.isHidden = false
    } completion: { (status) in
    }
    self.isProfileShown = true
  }
  
  @IBAction func backView2Tapped(_ sender: Any) {
    self.tabBarController?.tabBar.isHidden = false
    
    UIView.animate(withDuration: 0.3) {
        self.backViewProfile.isHidden = true
        self.profileViewLeading.constant = -343
        self.view.layoutIfNeeded()
        self.backViewProfile.isHidden = true
        self.backView2.isHidden = true
    } completion: { (status) in
    }
    self.isProfileShown = false
    
    print("Tapped")
  }
  
  @IBAction func backViewProfileTapped(_ sender: Any) {
//    self.tabBarController?.tabBar.isHidden = false
//
//    UIView.animate(withDuration: 0.3) {
//        self.backViewProfile.isHidden = true
//        self.profileViewLeading.constant = -343
//        self.view.layoutIfNeeded()
//        self.backViewProfile.isHidden = true
//    } completion: { (status) in
//    }
//    self.isProfileShown = false
  }
  
  //swipe
  private var beginPoint:CGFloat = 0.0
  private var difference:CGFloat = 0.0
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if isProfileShown{
         if let touch = touches.first{
            let location = touch.location(in: backViewProfile)
            beginPoint = location.x
        }
    }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    if isProfileShown{
        if let touch = touches.first{
            let location = touch.location(in: backViewProfile)
            
            let differenceFromBeginPoint = beginPoint - location.x
            
            if (differenceFromBeginPoint>0 || differenceFromBeginPoint<343){
                difference = differenceFromBeginPoint
                self.profileViewLeading.constant = -differenceFromBeginPoint
            }
        }
    }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    if  isProfileShown{
        if difference>100{
            UIView.animate(withDuration: 0.1) {
                self.profileViewLeading.constant = -343
            } completion: { (status) in
                self.isProfileShown = false
                self.backViewProfile.isHidden = true
              self.backView2.isHidden = true
              self.tabBarController?.tabBar.isHidden = false
            }
        }
        else{
            UIView.animate(withDuration: 0.1) {
                self.profileViewLeading.constant = 0
            } completion: { (status) in
                self.isProfileShown = true
                self.backViewProfile.isHidden = false
              self.backView2.isHidden = false
              self.tabBarController?.tabBar.isHidden = true
            }
        }
    }
  }
}

