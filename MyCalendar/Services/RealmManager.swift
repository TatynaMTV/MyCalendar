//
//  RealmManager.swift
//  MyCalendar
//
//  Created by Татьяна Мальчик on 10.02.2022.
//

import Foundation
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    
    private init() {}
    
    let realm = try! Realm()
    
    func saveModel(model: Task) {
        try! realm.write {
            realm.add(model)
        }
    }
    
    func deleteModel(model: Task) {
        try! realm.write {
            realm.delete(model)
        }
    }
}
