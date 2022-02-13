//
//  OptionsTaskTableViewController.swift
//  MyCalendar
//
//  Created by Татьяна Мальчик on 09.02.2022.
//

import UIKit

class OptionsTaskTableViewController: UITableViewController {
    
    var saveTaskButton = UIBarButtonItem()
    
    private let idOptionsTaskCell = "optionsTaskCell"
    private let idOptionsHeader = "optionsHeader"
    
    let headerNameArray = ["DATE", "START TIME", "END TIME", "EVENT", "DESCRIPTION"]
    var cellNameArray = [["Task date"],
                         ["Task start time"],
                         ["Task end time"],
                         ["Task name"],
                         ["Some notes"]]
    
    var taskModel = Task()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Options"
        view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.register(OptionTaskTableViewCell.self, forCellReuseIdentifier: idOptionsTaskCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsHeader)
        
        saveTaskButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveTaskButton
        if cellNameArray[0][0] != "Task date" {
            saveTaskButton.isEnabled = false
        } else {
            saveTaskButton.isEnabled = true
        }
    }
    
    @objc private func saveButtonTapped() {
        if taskModel.taskDate == nil || taskModel.taskStartTime == nil || taskModel.taskStartTime == nil || taskModel.taskName == "" {
            alertSave(title: "Error", message: "Fill in all the fields")
        } else {
            RealmManager.shared.saveModel(model: taskModel)
            taskModel = Task()
            
            alertSave(title: "Success", message: "The event was saved successfully")
            tableView.reloadData()
        }
    }

// MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return headerNameArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsTaskCell, for: indexPath) as! OptionTaskTableViewCell
        cell.cellTaskConfigure(nameArray: cellNameArray, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsHeader) as! HeaderOptionsTableViewCell
        header.headerLabel.text = headerNameArray[section]
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! OptionTaskTableViewCell
        
        switch indexPath {
        case [0,0]: alertDate(label: cell.сellLabel) { [weak self] date  in
            self?.taskModel.taskDate = date
        }
        case [1,0]: alertTime(label: cell.сellLabel) { [weak self] time in
            self?.taskModel.taskStartTime = time
        }
        case [2,0]: alertTime(label: cell.сellLabel) { [weak self] time in
            self?.taskModel.taskEndTime = time
        }
        case [3,0]: alertText(label: cell.сellLabel, name: "Event name", plaseholder: "Enter event name") { [weak self] name in
            self?.taskModel.taskName = name
        }
        case [4,0]: alertText(label: cell.сellLabel, name: "Description", plaseholder: "Some notes") { [weak self] text in
            self?.taskModel.taskDescriptor = text
        }
        default:
            print("Tap options tableView")
        }
    }
}
