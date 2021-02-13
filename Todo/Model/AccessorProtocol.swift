//
//  AccessorProtocol.swift
//  Todo
//
//  Created by 長谷侑弥 on 2021/02/06.
//

import Foundation
import RealmSwift

/// RealmデータベースへのAccessorはこのProtcolを実装する
protocol AccessorProtocol {
    /// protocolの準拠時に、具体的な型を指定する
    associatedtype ObjectType: Object
    func getByID(id: String) -> ObjectType?
    func getAll() -> [ObjectType]
    func set(data: Object) -> Bool
    func delete(data: Object) -> Bool
}
