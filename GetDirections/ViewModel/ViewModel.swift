//
//  ViewModel.swift
//  GetDirections
//
//  Created by Amg on 24/11/2020.
//

import Foundation
import MapKit
import CoreLocation

protocol UpdateUserLocationDelegate {
    func didUpdateUserLocation(region: MKCoordinateRegion)
}

class ViewModel: NSObject {
    
    typealias UserLocation = UpdateUserLocationDelegate
    
    // MARK: - Public Properties
    
    public lazy var locationManager: CLLocationManager = {
       return CLLocationManager()
    }()
    
    public var updateUserLocationDelegate: UserLocation?
    
    // MARK: - Private Properties
    
    private var setps = [MKRoute.Step]()
    private var stepCounter = 0
    private var route: MKRoute?
    private var showMapRoute = false
    private var navigationStarted = false
    private var locationDistance = 500
    
    // MARK: - Public Methods
    
    public func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            handleAutorizationStatus(locationManager: locationManager, status: locationManager.authorizationStatus)
        } else {
            print("Location services are not enabled")
        }
    }
    
    
    // MARK: - Private Methods
    
    fileprivate func handleAutorizationStatus(locationManager: CLLocationManager, status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            locationManager.requestLocation()
            guard let userLocation = locationManager.location?.coordinate else { print("Error When localize user"); return }
            centerViewToUserLocation(center: userLocation)
        default:
            break
        }
    }
    
    fileprivate func centerViewToUserLocation(center: CLLocationCoordinate2D) {
        updateUserLocationDelegate?.didUpdateUserLocation(region: MKCoordinateRegion(center: center, latitudinalMeters: CLLocationDistance(locationDistance), longitudinalMeters: CLLocationDistance(locationDistance)))
    }
}

// MARK: - CLLocation Manager Delegate
extension ViewModel: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        handleAutorizationStatus(locationManager: manager, status: manager.authorizationStatus)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !showMapRoute {
            guard let location = locations.last?.coordinate else { return }
            centerViewToUserLocation(center: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
