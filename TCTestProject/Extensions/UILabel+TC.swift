//
//  UILabel+TC.swift
//  TCTestProject
//
//  Created by HERIVONJY Aina on 11/11/2019.
//  Copyright © 2019 Aina Herivonjy. All rights reserved.
//

import UIKit

extension UILabel {

    /**
     Highlight text in a label.
     
     - parameter value: The full text.
     - parameter highlight: The text to be highlighted.
     */
    func setText(value: String?, highlight: String?) {

        guard let value = value, let highlight = highlight else { return }

        let attributedText = NSMutableAttributedString(string: value)
        let range = (value as NSString).range(of: highlight, options: .caseInsensitive)
        let higlightedTextAttributes: [NSAttributedString.Key: Any] = [
            .backgroundColor: UIColor.yellow,
            .foregroundColor: self.textColor!,
            .font:UIFont.boldSystemFont(ofSize: self.font.pointSize)
        ]

        attributedText.addAttributes(higlightedTextAttributes, range: range)
        self.attributedText = attributedText
    }

}
