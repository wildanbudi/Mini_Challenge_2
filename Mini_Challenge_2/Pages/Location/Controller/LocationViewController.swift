//
//  LocationViewController.swift
//  Mini_Challenge_2
//
//  Created by feedloop on 21/06/22.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController, UITableViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var locationSearchBar: UISearchBar!
    @IBOutlet var locationTableView: UITableView!
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Location"
        locationTableView.delegate = self
        locationTableView.dataSource = self
    }
    
    func turnOnLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("location manager")
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    // do stuff
                }
            }
        }
    }
}

extension LocationViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 99
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let locationCell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as! LocationTableViewCell
        
        locationCell.label1.text = "Turn On Location?"
        locationCell.label2.text = "To find the best restaurant"
        
        return locationCell
    }
}
