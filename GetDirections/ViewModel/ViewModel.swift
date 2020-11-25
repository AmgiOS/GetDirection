//
//  ViewModel.swift
//  GetDirections
//
//  Created by Amg on 24/11/2020.
//

import Foundation
import MapKit
import CoreLocation

protocol UserLocationDelegate {
    func didUpdateUserLocation(region: MKCoordinateRegion)
}

class ViewModel: NSObject {
    
    typealias UserLocation = UserLocationDelegate
    
    // MARK: - Public Properties
    
    public lazy var locationManager: CLLocationManager = {
       return CLLocationManager()
    }()
    
    public var updateUserLocationDelegate: UserLocation?
    public var currentLocation: MKCoordinateRegion?
    public var route: MKRoute?
    public var showMapRoute = false
    
    // MARK: - Private Properties
    
    private var setps = [MKRoute.Step]()
    private var stepCounter = 0
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
    
    public func geocodeAddressString(address: String) {
        CLGeocoder().geocodeAddressString(address) { (placemarks, error) in
            guard error == nil else { print(error?.localizedDescription ?? ""); return }
            guard let placemarks = placemarks, let placemark = placemarks.first, let location = placemark.location else { return }
            self.mapRoute(destinationCoordinate: location.coordinate)
        }
    }
    
    
    // MARK: - Private Methods
    
    fileprivate func handleAutorizationStatus(locationManager: CLLocationManager, status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            guard let userLocation = locationManager.location?.coordinate else { print("Error When localize user"); return }
            centerViewToUserLocation(center: userLocation)
        default:
            break
        }
    }
    
    fileprivate func centerViewToUserLocation(center: CLLocationCoordinate2D) {
        let location = MKCoordinateRegion(center: center, latitudinalMeters: CLLocationDistance(locationDistance), longitudinalMeters: CLLocationDistance(locationDistance))
        currentLocation = location
        updateUserLocationDelegate?.didUpdateUserLocation(region: location)
    }
    
    fileprivate func mapRoute(destinationCoordinate: CLLocationCoordinate2D) {
        guard let sourceCoordinate = locationManager.location?.coordinate else { return }
        
        let sourceItem = MKMapItem(placemark: MKPlacemark(coordinate: sourceCoordinate))
        let destinationItem = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate))
        
        let routeRequest = MKDirections.Request()
        routeRequest.source = sourceItem
        routeRequest.destination = destinationItem
        routeRequest.transportType = .walking
        
        let directions = MKDirections(request: routeRequest)
        directions.calculate { (response, error) in
            guard error == nil else { print(error?.localizedDescription ?? ""); return }
            
            guard let response = response, let route = response.routes.first else { return }
            self.route = route
        }
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
