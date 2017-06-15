//
//  Car.swift
//  CarsReservation
//
//  Created by Polina Petrenko on 15.06.17.
//  Copyright © 2017 Polina Petrenko. All rights reserved.
//

import UIKit

class Car {
    var carImage: UIImage!
    var carBrand: String
    var carModel: String
    var carPlateNumber: String
    var carLocation: CarLocation
    
    init(image: UIImage?, brand: String, model: String, plateNumber: String, location: CarLocation) {
        if let carImage = image {
            self.carImage = carImage
        }
        carBrand = brand
        carModel = model
        carPlateNumber = plateNumber
        carLocation = location
    }
}
