//
//  LocationManager.swift
//  OtogeNavi
//
//  Created by Galvin Gao on 5/29/24.
//

import CoreLocation
import Foundation

final class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    var manager = CLLocationManager()
    
    func checkLocationAuthorization() {
        manager.delegate = self
        
        switch manager.authorizationStatus {
        case .notDetermined: // The user choose allow or deny your app to get the location yet
            manager.requestWhenInUseAuthorization()
            
        case .restricted: // The user cannot change this app’s status, possibly due to active restrictions such as parental controls being in place.
            print("Location restricted")
            
        case .denied: // The user dennied your app to get location or disabled the services location or the phone is in airplane mode
            print("Location denied")
            
        case .authorizedAlways: // This authorization allows you to use all location services and receive location events whether or not your app is in use.
            print("Location authorizedAlways")
            
        case .authorizedWhenInUse: // This authorization allows you to use all location services and receive location events only when your app is in use
            print("Location authorized when in use")
            
        @unknown default:
            print("Location service disabled")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) { // Trigged every time authorization status changes
        checkLocationAuthorization()
    }
}
