//
//  OptionTaskTableViewCell.swift
//  MyCalendar
//
//  Created by Татьяна Мальчик on 09.02.2022.
//

import UIKit

class OptionTaskTableViewCell: UITableViewCell {

    let backgroundViewCell = UIView()
    let сellLabel = UILabel(text: "", font: UIFont.systemFont(ofSize: 14), textAlignment: .left, color: .black)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        setUpBackgroundViewCell()
        setUpNameCellLable()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpBackgroundViewCell() {
        backgroundViewCell.backgroundColor = .white
        backgroundViewCell.layer.cornerRadius = 10
        backgroundViewCell.contentMode = .scaleAspectFit
        backgroundViewCell.translatesAutoresizingMaskIntoConstraints = false
    }
    func setUpNameCellLable() {
        сellLabel.font = UIFont.systemFont(ofSize: 16)
        сellLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func cellTaskConfigure(nameArray: [[String]], indexPath: IndexPath) {
        сellLabel.text = nameArray[indexPath.section][indexPath.row]
    }
    
//MARK: - Set constraints
    
    func setConstraints() {
        self.addSubview(backgroundViewCell)
        NSLayoutConstraint.activate([
            backgroundViewCell.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            backgroundViewCell.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2),
            backgroundViewCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            backgroundViewCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
        
        self.addSubview(сellLabel)
        NSLayoutConstraint.activate([
            сellLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            сellLabel.leadingAnchor.constraint(equalTo: backgroundViewCell.leadingAnchor, constant: 10),
            сellLabel.trailingAnchor.constraint(equalTo: backgroundViewCell.trailingAnchor, constant: -10)
        ])
    }
}
