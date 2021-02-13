//
//  TodoAccessor.swift
//  Todo
//
//  Created by 長谷侑弥 on 2021/02/06.
//

import Foundation
import RealmSwift

class TodoAccessor: AccessorBase, AccessorProtocol {

    typealias ObjectType = TodoModel

    // Singleton
    static let sharedInstance = TodoAccessor()
    private override init() {
        super.init()
    }

    func getByID(id: String) -> TodoModel? {
        let models = super.realm.objects(TodoModel.self).filter("id = '\(id)'")
        if models.count > 0 {
            return models[0]
        } else {
            return nil
        }
    }

    func getAll() -> [ObjectType] {
        return Array(realm.objects(TodoModel.self))
    }
}
