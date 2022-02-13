//
//  AlertSave.swift
//  MyCalendar
//
//  Created by Татьяна Мальчик on 10.02.2022.
//

import UIKit

extension UIViewController {
    func alertSave(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
