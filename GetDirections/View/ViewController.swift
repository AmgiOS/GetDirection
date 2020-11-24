//
//  ViewController.swift
//  GetDirections
//
//  Created by Amg on 23/11/2020.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let viewModel = ViewModel()
    
    private lazy var mapView: MenuView = {
        let mapView = MenuView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        return mapView
    }()
    
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setLocation()
    }
    
    // MARK: - Private Methods
    
    private func setUpView() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        mapView.mapView.delegate = self
        mapView.mapView.showsUserLocation = true
    }
    
    private func setLocation() {
        viewModel.checkLocationServices()
//        viewModel.updateUserLocationDelegate = self
        mapView.mapView.setRegion(viewModel.currentLocation ?? MKCoordinateRegion(), animated: true)
    }
}

extension ViewController: MKMapViewDelegate {
    
}

/// Enable this method for have location user in real time
//extension ViewController: UserLocationDelegate {
//    func didUpdateUserLocation(region: MKCoordinateRegion) {
//        mapView.mapView.setRegion(region, animated: true)
//    }
//}
