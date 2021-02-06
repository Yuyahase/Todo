//
//  Todo.swift
//  Todo
//
//  Created by 長谷侑弥 on 2021/02/05.
//

import Foundation

class Todo {
    var name: String
    var category: Category

    enum Category: String{
        case business
        case hobby
        case other
    }

    init(name: String, category: Category) {
        self.name = name
        self.category = category
    }
}


