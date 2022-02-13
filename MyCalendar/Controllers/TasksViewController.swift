//
//  TasksViewController.swift
//  MyCalendar
//
//  Created by Татьяна Мальчик on 09.02.2022.
//

import UIKit
import FSCalendar
import RealmSwift

class TasksViewController: UIViewController {
    
    var myCalendar = FSCalendar()
    var calendarHeightConstraint = NSLayoutConstraint()
    
    var showHideButton = UIButton()
    var tasksTableView = UITableView()
    
    let idTaskCell = "taskCell"
    
    var currentTask: Task!
    
    let localRealm = try! Realm()
    var taskArray: Results<Task>!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tasksTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "My Activity"
        self.view.backgroundColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .bold)]
        
        createCalendar()
        createShowHideButton()
        createTasksTableView()
        setConstraints()
        tasksOnDay(date: Date())

        tasksTableView.register(TaskTableViewCell.self, forCellReuseIdentifier: idTaskCell)
        
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    
    @objc func showHideButtonTapped() {
        if myCalendar.scope == .week {
            myCalendar.setScope(.month, animated: true)
            showHideButton.setTitle("Close calendar", for: .normal)
        } else {
            myCalendar.setScope(.week, animated: true)
            showHideButton.setTitle("Open calendar", for: .normal)
        }
    }
    
    @objc func addButtonTapped() {
        let optionsTask = OptionsTaskTableViewController()
        navigationController?.pushViewController(optionsTask, animated: true)
    }
    
    func editingModel(taskModel: Task) {
        let optionsTask = OptionsTaskTableViewController()
        optionsTask.taskModel = taskModel
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        guard let date = taskModel.taskDate else { return }
        let dateTask = dateFormatter.string(from: date)
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        guard let startTimeDate = taskModel.taskStartTime, let endTimeDate = taskModel.taskEndTime else { return }
        let startTime = timeFormatter.string(from: startTimeDate)
        let endTime = timeFormatter.string(from: endTimeDate)
        
        optionsTask.cellNameArray = [
            [dateTask],
            [startTime],
            [endTime],
            [taskModel.taskName],
            [taskModel.taskDescriptor]
        ]
        
        navigationController?.pushViewController(optionsTask, animated: true)
    }
    
    private func tasksOnDay(date: Date) {
        let dateStart = date
        let dateEnd: Date = {
            let components = DateComponents(day: 1, second: -1)
            return Calendar.current.date(byAdding: components, to: dateStart)!
        }()
        
        let predicate = NSPredicate(format: "taskDate BETWEEN %@", [dateStart, dateEnd])
        taskArray = localRealm.objects(Task.self).filter(predicate).sorted(byKeyPath: "taskStartTime")
        tasksTableView.reloadData()
    }
}

// MARK: - TableView delegate & data sourse

extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.isEmpty ? 0 : taskArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idTaskCell, for: indexPath) as! TaskTableViewCell
        let model = taskArray[indexPath.row]
        cell.configure(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = taskArray[indexPath.row]
        editingModel(taskModel: model)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editingRow = taskArray[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandelr in
            RealmManager.shared.deleteModel(model: editingRow)
            self.tasksTableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: - Calendar delegate & data sourse

extension TasksViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightConstraint.constant = bounds.height
        view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        tasksOnDay(date: date)
    }
}

// MARK: - Set constraints

extension TasksViewController {
    func createCalendar() {
        myCalendar.delegate = self
        myCalendar.dataSource = self
        myCalendar.locale = NSLocale(localeIdentifier: "en_US") as Locale
        myCalendar.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func createShowHideButton() {
        showHideButton.setTitle("Close calendar", for: .normal)
        showHideButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        showHideButton.setTitleColor(.black, for: .normal)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func createTasksTableView() {
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
        tasksTableView.bounces = false
        tasksTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints() {
        self.view.addSubview(myCalendar)
        
        calendarHeightConstraint = NSLayoutConstraint(item: myCalendar, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        myCalendar.addConstraint(calendarHeightConstraint)
        
        NSLayoutConstraint.activate([
            myCalendar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 90),
            myCalendar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            myCalendar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        ])
        
        self.view.addSubview(showHideButton)
        
        NSLayoutConstraint.activate([
            showHideButton.topAnchor.constraint(equalTo: myCalendar.bottomAnchor, constant: 0),
            showHideButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            showHideButton.heightAnchor.constraint(equalToConstant: 20),
            showHideButton.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        self.view.addSubview(tasksTableView)
        
        NSLayoutConstraint.activate([
            tasksTableView.topAnchor.constraint(equalTo: showHideButton.bottomAnchor, constant: 10),
            tasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tasksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tasksTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
