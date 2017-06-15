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
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        addBlurEffectToTheButtonsView()
        
        let camera = GMSCameraPosition.camera(withLatitude: Constants.MoscowCenterLatitude, longitude: Constants.MoscowCenterLongitude, zoom: 10.0)
        mapView.camera = camera
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mapView.clear()
        
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
    }
    
    func addMarker(location: CarLocation) {
        let position = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let marker = GMSMarker(position: position)
        marker.map = mapView
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        performSegue(withIdentifier: "SegueFromMapToListOfCars", sender: self)
        return true
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
