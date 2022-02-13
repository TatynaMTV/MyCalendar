//
//  TaskModelJSON.swift
//  MyCalendar
//
//  Created by Татьяна Мальчик on 11.02.2022.
//

import Foundation

class TaskModelJSON: Decodable {
    var id: Int
    var dateStart: Int
    var dateFinish: Int
    var name: String
    var description: String
    
    enum CodingKeys: String, CodingKey, Decodable {
        case id
        case dateStart = "date_start"
        case dateFinish = "date_finish"
        case name
        case description
    }
}
