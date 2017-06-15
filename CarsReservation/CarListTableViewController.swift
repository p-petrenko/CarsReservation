//
//  CarListTableViewController.swift
//  CarsReservation
//
//  Created by Polina Petrenko on 15.06.17.
//  Copyright © 2017 Polina Petrenko. All rights reserved.
//

import UIKit

class CarListTableViewController: UITableViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func reserveCar(_ sender: UIButton) {
        if appDelegate.chosenCarIndex != nil {
            appDelegate.chosenCarIndex = nil
        } else {
            appDelegate.chosenCarIndex = sender.tag
        }
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if appDelegate.chosenCarIndex != nil {
            return 1
        } else {
            return appDelegate.carsArray.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> CarTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarCell", for: indexPath) as! CarTableViewCell
        guard let carsArray = appDelegate.carsArray else {
            return CarTableViewCell()
        }

        if let carNumber = appDelegate.chosenCarIndex {
            cell.reserveButton.setTitle("Завершить", for: .normal)
            cell.car = carsArray[carNumber]
        } else {
            cell.reserveButton.setTitle("Забронировать", for: .normal)
            cell.reserveButton.tag = indexPath.row
            cell.car = carsArray[indexPath.row]
        }
        return cell
    }
    
}
