//
//  CarDetailViewController.swift
//  TCTestProject
//
//  Created by HERIVONJY Aina on 10/11/2019.
//  Copyright © 2019 Aina Herivonjy. All rights reserved.
//

import UIKit

class CarDetailViewController: UIViewController {

    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var equipmentTextView: UITextView!
    
    var car:Car?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupView()
    }
    
    func setupView() {
        guard let car = self.car else {
            return
        }
        if let urlString = car.picture {
            carImageView?.setImageURL(url: urlString)
        }
        
        if let carMake = car.make {
            self.title = carMake
            self.makeLabel.text = carMake
        }
        if let carModel = car.model {
            self.modelLabel.text = carModel
        }
        yearLabel.text = "\(car.year)"
        if let equipments = car.equipments {
            self.equipmentTextView.text = equipments.joined(separator: "\n")
        }
    }
    
}
