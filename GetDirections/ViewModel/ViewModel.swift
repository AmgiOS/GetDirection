//
//  ViewModel.swift
//  GetDirections
//
//  Created by Amg on 24/11/2020.
//

import Foundation
import MapKit
import CoreLocation

class ViewModel {
    
    // MARK: - Public Properties
    
    public lazy var locationManager: CLLocationManager = {
       return CLLocationManager()
    }()
    
    // MARK: - Private Properties
    
    private var setps = [MKRoute.Step]()
    private var stepCounter = 0
    private var route: MKRoute?
    private var showMapRoute = false
    private var navigationStarted = false
    private var locationDistance = 500
    
    // MARK: - Public Methods
    
    
    // MARK: - Private Methods
}
