//
//  TaskTableViewCell.swift
//  MyCalendar
//
//  Created by Татьяна Мальчик on 09.02.2022.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    let taskStartTime = UILabel(text: "", font: UIFont.systemFont(ofSize: 14), textAlignment: .center, color: .black)
    let taskEndTime = UILabel(text: "", font: UIFont.systemFont(ofSize: 14), textAlignment: .center, color: .gray)
    let taskName = UILabel(text: "", font: UIFont.systemFont(ofSize: 20, weight: .bold), textAlignment: .left, color: .black)
    let taskDescription = UILabel(text: "", font: UIFont.systemFont(ofSize: 14), textAlignment: .left, color: .darkGray)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        taskName.adjustsFontSizeToFitWidth = false
        taskDescription.numberOfLines = 2
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: Task) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        guard let startTime = model.taskStartTime, let endTime = model.taskEndTime else { return }
        taskStartTime.text = dateFormatter.string(from: startTime)
        taskEndTime.text = dateFormatter.string(from: endTime)
        taskName.text = model.taskName
        taskDescription.text = model.taskDescriptor
    }

    func setConstraints() {
        let timeStackView = UIStackView(arrangedSubviews: [taskStartTime, taskEndTime],
                                        axis: .vertical,
                                        spacing: 0,
                                        distribution: .fillEqually)
        self.addSubview(timeStackView)
        NSLayoutConstraint.activate([
            timeStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            timeStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            timeStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            timeStackView.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        let taskStackView = UIStackView(arrangedSubviews: [taskName, taskDescription],
                                        axis: .vertical,
                                        spacing: 0,
                                        distribution: .fillEqually)
        self.addSubview(taskStackView)
        NSLayoutConstraint.activate([
            taskStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            taskStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            taskStackView.leadingAnchor.constraint(equalTo: timeStackView.trailingAnchor, constant: 15),
            taskStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
}
