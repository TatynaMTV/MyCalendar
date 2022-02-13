//
//  UILabel.swift
//  MyCalendar
//
//  Created by Татьяна Мальчик on 09.02.2022.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont?, textAlignment: NSTextAlignment, color: UIColor) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = color
        self.textAlignment = textAlignment
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
