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
    
    @objc private func tapGestureDirectionButton() {
       getDirection()
    }
    
    @objc private func tapGestureNavigationButton() {
        
    }
    
    private func setUpView() {
        view.endEditing(true)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        mapView.mapView.delegate = self
        mapView.mapView.showsUserLocation = true
        mapView.getDirectionButton.addTarget(self, action: #selector(tapGestureDirectionButton), for: .touchUpInside)
        mapView.navigationButton.addTarget(self, action: #selector(tapGestureNavigationButton), for: .touchUpInside)
    }
    
    private func setLocation() {
        viewModel.checkLocationServices()
//        viewModel.updateUserLocationDelegate = self
        mapView.mapView.setRegion(viewModel.currentLocation ?? MKCoordinateRegion(), animated: true)
    }
    
    private func getDirection() {
        guard let text = mapView.textField.text else { return }
        viewModel.showMapRoute = true
        mapView.textField.endEditing(true)
        
        viewModel.geocodeAddressString(address: text)
        addOverlayInMapView()
    }
    
    private func addOverlayInMapView() {
        guard let overlay = viewModel.route?.polyline else { return }
        mapView.mapView.addOverlay(overlay)
        mapView.mapView.setVisibleMapRect(overlay.boundingMapRect, edgePadding: UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30), animated: true)
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .systemBlue
        return renderer
    }
}

/// Enable this protocol and delegate  for have user location in real time
//extension ViewController: UserLocationDelegate {
//    func didUpdateUserLocation(region: MKCoordinateRegion) {
//        mapView.mapView.setRegion(region, animated: true)
//    }
//}
