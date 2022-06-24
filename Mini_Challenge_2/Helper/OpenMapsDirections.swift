//
//  OpenMapsDirections.swift
//  Mini_Challenge_2
//
//  Created by feedloop on 19/06/22.
//

import Foundation
import CoreLocation
import MapKit
import UIKit

class OpenMapDirections {
    static func present(in viewController: UIViewController, sourceView: UIView, restaurant: Restaurants) {
        let actionSheet = UIAlertController(title: "Show Restaurant Location", message: "Choose an app to show location", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Google Maps", style: .default, handler: { _ in
            let url = URL(string: "https://maps.google.com/?q=\(restaurant.latitude),\(restaurant.longitude)")!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Apple Maps", style: .default, handler: { _ in
            let coordinate = CLLocationCoordinate2DMake(restaurant.latitude,restaurant.longitude)
            let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
            mapItem.name = "Destination"
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsMapTypeKey: MKLaunchOptionsMapCenterKey])
        }))
        actionSheet.popoverPresentationController?.sourceRect = sourceView.bounds
        actionSheet.popoverPresentationController?.sourceView = sourceView
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        viewController.present(actionSheet, animated: true, completion: nil)
    }
}
