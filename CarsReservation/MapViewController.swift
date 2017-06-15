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
        
        let camera = GMSCameraPosition.camera(withLatitude: Constants.MoscowCenterLatitude, longitude: Constants.MoscowCenterLongitude, zoom: 10.0)
        mapView.camera = camera
        
        addRandomMarkers()
        addBlurEffectToTheButtonsView()
    }
    
    func addRandomMarkers() {
        for _ in appDelegate.carsArray {
            let randomLatitude = CLLocationDegrees(randomDouble(min: Constants.MoscowMinLatitude, max: Constants.MoscowMaxLatitude))
            let randomLogitude = CLLocationDegrees(randomDouble(min: Constants.MoscowMinLongitude, max: Constants.MoscowMaxLongitude))
            
            let position = CLLocationCoordinate2D(latitude: randomLatitude, longitude: randomLogitude)
            let marker = GMSMarker(position: position)
            marker.map = mapView
        }
    }
    
    func randomDouble(min: Double, max: Double) -> Double {
        return (Double(arc4random()) / 0xFFFFFFFF) * (max - min) + min
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
