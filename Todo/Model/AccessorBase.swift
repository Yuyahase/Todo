//
//  AccessorBase.swift
//  Todo
//
//  Created by 長谷侑弥 on 2021/02/06.
//

import Foundation
import RealmSwift

class AccessorBase {

    let realm: Realm

    /// コンストラクタ
    init() {
        // Realmオブジェクト生成
       realm = try! Realm()
    }

    /// データをUpdateする
    /// - parameter data: データ
    /// - returns: true: 成功
    func set(data: Object) -> Bool {
        do {
            try realm.write {
                realm.add(data, update: .all)   //プライマリキーで上書きする
            }
            return true
        } catch {
            print("\n--Error! AccessorBase#set")
        }
        return false
    }

    /// データをDeleteする
    /// - parameter data: データ
    /// - returns: true: 成功
    func delete(data: Object) -> Bool {
        do {
            try realm.write {
                realm.delete(data)
            }
            return true
        } catch {
            print("\n--Error! AccessorBase#delete")
        }
        return false
    }
}

