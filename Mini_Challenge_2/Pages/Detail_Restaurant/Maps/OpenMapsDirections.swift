import CoreLocation
import MapKit
import UIKit

class OpenMapDirections {
    // If you are calling the coordinate from a Model, don't forgot to pass it in the function parenthesis.
    static func present(in viewController: UIViewController, sourceView: UIView) {
        let actionSheet = UIAlertController(title: "Open Location", message: "Choose an app to open direction", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Google Maps", style: .default, handler: { _ in
            // Pass the coordinate inside this URL
            let url = URL(string: "https://www.google.co.id/maps/place/Rumah+Makan+Kapau+Jaya/@-6.9021289,107.6057632,17z/data=!3m1!4b1!4m5!3m4!1s0x2e68e645df5be507:0xbc437153d1819d27!8m2!3d-6.9021342!4d107.6079519?hl=id")!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Apple Maps", style: .default, handler: { _ in
            // Pass the coordinate that you want here
            let coordinate = CLLocationCoordinate2DMake(48.8566,2.3522)
            let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
            mapItem.name = "Destination"
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
        }))
        actionSheet.popoverPresentationController?.sourceRect = sourceView.bounds
        actionSheet.popoverPresentationController?.sourceView = sourceView
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        viewController.present(actionSheet, animated: true, completion: nil)
    }
}
