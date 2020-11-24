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
    }
}

extension ViewController: MKMapViewDelegate {
    
}
