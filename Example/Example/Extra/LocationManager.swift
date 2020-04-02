import UIKit
import CoreLocation

class LocationManager: NSObject {
    static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    
    @objc dynamic var currentLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocation() {
        guard CLLocationManager.locationServicesEnabled() else {
            displayLocationServicesDisabledAlert()
            return
        }
        
        let status = CLLocationManager.authorizationStatus()
        guard status != .denied else {
            displayLocationServicesDeniedAlert()
            return
        }
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    private func displayLocationServicesDisabledAlert() {
        let message = "Location services are not enabled on this device. Please enable location services in Settings."
        let alertController = UIAlertController(title: "Location Services",
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        displayAlert(alertController)
    }
    
    private func displayLocationServicesDeniedAlert() {
        let message = "Location services were previously denied by the user. Please enable location services for this app in Settings."
        let alertController = UIAlertController(title: "Location Services",
                                                message: message,
                                                preferredStyle: .alert)
        let settingsButtonTitle = "Settings"
        let openSettingsAction = UIAlertAction(title: settingsButtonTitle, style: .default) { (_) in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                // Take the user to the Settings app to change permissions.
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        }
        
        let cancelButtonTitle = "Cancel"
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil)
                
        alertController.addAction(cancelAction)
        alertController.addAction(openSettingsAction)
        displayAlert(alertController)
    }
    
    private func displayAlert(_ controller: UIAlertController) {
        guard let viewController = UIApplication.shared.keyWindow?.rootViewController else {
            fatalError("The key window did not have a root view controller")
        }
        viewController.present(controller, animated: true, completion: nil)
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Handle any errors returns from Location Services.
    }
}
