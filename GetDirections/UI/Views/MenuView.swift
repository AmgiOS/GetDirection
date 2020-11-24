//
//  MapView.swift
//  GetDirections
//
//  Created by Amg on 23/11/2020.
//

import Foundation
import MapKit
import CoreLocation
import UIKit

class MenuView: UIView {
    
    // MARK: - Public Properties
    
    public var locationManager: CLLocationManager?
    
    public lazy var mapView: MKMapView = {
       let view = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }()
    
    // MARK: - Private Properties
    
    private lazy var menuView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        mapView.addSubview(view)
        return view
    }()
    
    private lazy var directionLabel: UILabel = {
        let label = UILabel()
        label.text = "Where do you want to go ?"
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        menuView.addSubview(label)
        return label
    }()
    
    private lazy var textField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Enter Your Destination"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        menuView.addSubview(textField)
        return textField
    }()
    
    private lazy var getDirectionButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "Get Direction"
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        menuView.addSubview(button)
        return button
    }()
    
    private lazy var navigationButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "Get Direction"
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        menuView.addSubview(button)
        return button
    }()
    
    // MARK: - LifeCycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUIComponents()
    }
    
    // MARK: - Private Methods
    
    private func setUIComponents() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            menuView.topAnchor.constraint(equalTo: mapView.topAnchor),
            menuView.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
            menuView.leadingAnchor.constraint(equalTo: mapView.leadingAnchor),
            
            directionLabel.topAnchor.constraint(equalTo: menuView.topAnchor, constant: 70),
            directionLabel.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            directionLabel.leadingAnchor.constraint(equalTo: menuView.leadingAnchor, constant: 10),
            
            textField.topAnchor.constraint(equalTo: directionLabel.bottomAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: menuView.leadingAnchor, constant: 10),
            textField.widthAnchor.constraint(equalToConstant: 230),
            textField.heightAnchor.constraint(equalToConstant: 30),
            
            getDirectionButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            getDirectionButton.rightAnchor.constraint(equalTo: menuView.rightAnchor, constant: -5),
            getDirectionButton.widthAnchor.constraint(equalToConstant: 90),
            getDirectionButton.heightAnchor.constraint(equalToConstant: 30),
            
            
            navigationButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 15),
            navigationButton.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            navigationButton.leadingAnchor.constraint(equalTo: menuView.leadingAnchor, constant: 15),
            navigationButton.bottomAnchor.constraint(equalTo: menuView.bottomAnchor, constant: -10)
        ])
    }
}
