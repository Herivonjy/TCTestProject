//
//  CarListCell.swift
//  TCTestProject
//
//  Created by HERIVONJY Aina on 10/11/2019.
//  Copyright © 2019 Aina Herivonjy. All rights reserved.
//

import UIKit

class CarListCell: UITableViewCell {
    
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var markLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    func setup(car:Car, searchText:String?) {
        if let urlString = car.picture {
            self.imageView?.setImageURL(url: urlString)
            /*
            do {
                self.imageView?.image = UIImage(data: try Data(contentsOf: URL(string: urlString)!))
            } catch  {
                
            }
            */
        }
        if let carMake = car.make {
            markLabel.setText(value: carMake, highlight: searchText)
        }
        if let carModel = car.model {
            modelLabel.setText(value: carModel, highlight: searchText)
        }
        yearLabel.text = "\(car.year)"
        
        self.accessoryType = .disclosureIndicator
    }

}
