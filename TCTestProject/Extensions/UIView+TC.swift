//
//  UIView+TC.swift
//  TCTestProject
//
//  Created by HERIVONJY Aina on 10/11/2019.
//  Copyright © 2019 Aina Herivonjy. All rights reserved.
//

import UIKit

extension UIView {
    func applyRoundedCorner() {
        self.layer.cornerRadius = 5
    }
    
    func applyHorizontalRounded(borderWidth:CGFloat, borderColor:UIColor, shadow:Bool) {
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        if shadow {
            self.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        }
        self.layoutIfNeeded()
    }
    
    func animateHide() {
        UIView.animate(withDuration: 0.5) {
            self.isHidden = true
        }
    }
    
    func animateShow() {
        UIView.animate(withDuration: 0.5) {
            self.isHidden = false
        }
    }
}

