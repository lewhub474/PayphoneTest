//
//  CoreLocationManager.swift
//  PayphoneTest
//
//  Created by Macky on 29/03/25.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var latitude: Double = 0.0
    @Published var longitude: Double = 0.0
    @Published var locationError: String?
    @Published var showLocationPopup: Bool = false

    private var locationManager: CLLocationManager?

    func requestLocationPermission() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
    }

    func getCurrentLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.startUpdatingLocation()
        } else {
            locationError = "Los servicios de localización están desactivados."
            showLocationPopup = true
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
            locationError = nil
            showLocationPopup = true
            locationManager?.stopUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationError = "No se pudo obtener la ubicación. Intenta nuevamente."
        showLocationPopup = true
    }
}
