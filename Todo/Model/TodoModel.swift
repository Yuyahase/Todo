//
//  TodoModel.swift
//  Todo
//
//  Created by 長谷侑弥 on 2021/02/06.
//

import Foundation
import RealmSwift

class TodoModel: Object {
    dynamic var id: String = ""
    dynamic var taskName: String = ""
    dynamic var note: String = ""
    override static func primaryKey() -> String? {
        return "id"
    }
}



