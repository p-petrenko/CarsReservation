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
    
    init(image: UIImage?, brand: String, model: String, plateNumber: String) {
        if let carImage = image {
            self.carImage = carImage
        }
        carBrand = brand
        carModel = model
        carPlateNumber = plateNumber
    }
}
