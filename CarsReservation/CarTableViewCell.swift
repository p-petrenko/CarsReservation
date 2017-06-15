//
//  CarTableViewCell.swift
//  CarsReservation
//
//  Created by Polina Petrenko on 15.06.17.
//  Copyright © 2017 Polina Petrenko. All rights reserved.
//

import UIKit

class CarTableViewCell: UITableViewCell {

    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carBrand: UILabel!
    @IBOutlet weak var carModel: UILabel!
    @IBOutlet weak var plateNumber: UILabel!
    @IBOutlet weak var reserveButton: UIButton!
    
    var car: Car! {
        didSet {
            updateCellData()
        }
    }
    
    func updateCellData() {
        carImageView.image = car.carImage
        carBrand.text = car.carBrand
        carModel.text = car.carModel
        plateNumber.text = car.carPlateNumber
    }  
}
