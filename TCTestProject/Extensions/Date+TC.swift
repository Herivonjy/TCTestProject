//
//  Date+TC.swift
//  TCTestProject
//
//  Created by HERIVONJY Aina on 12/11/2019.
//  Copyright © 2019 Aina Herivonjy. All rights reserved.
//

import Foundation

extension Date {
    func toString(dateFormat:String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
}
