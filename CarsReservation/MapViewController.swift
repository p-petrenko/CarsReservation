//
//  ViewController.swift
//  CarsReservation
//
//  Created by Polina Petrenko on 14.06.17.
//  Copyright © 2017 Polina Petrenko. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var buttonsBackgroundView: UIView!
    
    var locationManager = CLLocationManager()
    var didFindMyLocation = false
    var locationButtonWasTapped = false
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        // notify the locationManager every 100 meters
        locationManager.distanceFilter = 100.0;
        let camera = GMSCameraPosition.camera(withLatitude: Constants.MoscowCenterLatitude, longitude: Constants.MoscowCenterLongitude, zoom: 10.0)
        mapView.camera = camera
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addBlurEffectToTheButtonsView()
        mapView.clear()
        locationManager.stopUpdatingLocation()
        if let carIndex = appDelegate.chosenCarIndex {
            // the car was chosen -> show only this car on the map
            let carLocation = appDelegate.carsArray[carIndex].carLocation
            addMarker(location: carLocation)
        } else {
            for car in appDelegate.carsArray {
                let carLocation = car.carLocation
                addMarker(location: carLocation)
            }
        }
        if locationButtonWasTapped {
            getUserLocation()
        }
    }
    
    @IBAction func getUserLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        let authorizationStatus = CLLocationManager.authorizationStatus()
        if authorizationStatus == CLAuthorizationStatus.notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if authorizationStatus == .authorizedWhenInUse {
            didFindMyLocation = false
            locationManager.stopUpdatingLocation()
            locationManager.startUpdatingLocation()
        }
        locationButtonWasTapped = true
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        performSegue(withIdentifier: "SegueFromMapToListOfCars", sender: self)
        return true
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse && locationButtonWasTapped {
            manager.startUpdatingLocation()
            mapView.isMyLocationEnabled = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !didFindMyLocation {
            let myLocation: CLLocation = locations.last!
            mapView.camera = GMSCameraPosition.camera(withTarget: myLocation.coordinate, zoom: 10.0)
            addUserLocationMarker(location: myLocation)
            didFindMyLocation = true
        }
    }
    
    func addMarker(location: CarLocation) {
        let position = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let marker = GMSMarker(position: position)
        marker.map = mapView
    }
    
    func addUserLocationMarker(location: CLLocation) {
        let position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let marker = GMSMarker(position: position)
        marker.icon = GMSMarker.markerImage(with: .blue)
        marker.map = mapView
    }
    
    func addBlurEffectToTheButtonsView() {
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.buttonsBackgroundView.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            self.buttonsBackgroundView.addSubview(blurEffectView)
        }
    }
}
