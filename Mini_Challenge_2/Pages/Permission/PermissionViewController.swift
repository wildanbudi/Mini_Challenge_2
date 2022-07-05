//
//  PermissionViewController.swift
//  Mini_Challenge_2
//
//  Created by Wildan Budi on 04/07/22.
//

import UIKit
import CoreLocation
import MapKit

class PermissionViewController: UIViewController, CLLocationManagerDelegate{

    let locationManager = CLLocationManager()
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBAction func turnOnButton(_ sender: Any) {
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
    }
    @IBAction func laterButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        cancelButton.layer.cornerRadius = 5
        cancelButton.layer.borderWidth = 4
        cancelButton.layer.borderColor = UIColor(red: 90/255, green: 141/255, blue: 38/255, alpha: 1).cgColor
        cancelButton.tintColor = UIColor(red: 90/255, green: 141/255, blue: 38/255, alpha: 1)
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
