//
//  HeaderOptionsTableViewCell.swift
//  MyCalendar
//
//  Created by Татьяна Мальчик on 09.02.2022.
//

import UIKit

class HeaderOptionsTableViewCell: UITableViewHeaderFooterView {
    let headerLabel = UILabel(text: "", font: UIFont.systemFont(ofSize: 16, weight: .light), textAlignment: .left, color: .darkGray)
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func headerConfigure(nameArray: [String], section: Int) {
        headerLabel.text = nameArray[section]
    }
    
 
//MARK: - Установка UIStackView и констрейнтов
    
    func setConstraints() {
        self.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
}
