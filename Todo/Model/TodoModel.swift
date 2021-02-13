//
//  TodoModel.swift
//  Todo
//
//  Created by 長谷侑弥 on 2021/02/06.
//

import Foundation
import RealmSwift

class TodoModel: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var taskName: String = ""
    @objc dynamic var note: String?
    @objc dynamic var deadLine: Date?
    override static func primaryKey() -> String? {
        return "id"
    }
}



