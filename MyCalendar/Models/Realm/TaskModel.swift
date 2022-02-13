//
//  TaskModel.swift
//  MyCalendar
//
//  Created by Татьяна Мальчик on 10.02.2022.
//

import Foundation
import RealmSwift

class Task: Object {
    @Persisted var taskDate: Date?
    @Persisted var taskStartTime: Date?
    @Persisted var taskEndTime: Date?
    @Persisted var taskName: String = ""
    @Persisted var taskDescriptor: String = "Unknown"
}
