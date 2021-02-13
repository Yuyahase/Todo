//
//  Date+toString.swift
//  Todo
//
//  Created by 長谷侑弥 on 2021/02/07.
//

import Foundation
extension Date {

    enum Format: String {

        case yyyyMdEHm = "yyyy/M/d(E) H:mm"
        case yyyyMMdd = "yyyy/MM/dd"
        case yyyyMdE = "yyyy/M/d(E)"
        case MDEHM = "M/d(E)HH:mm"
        case MDE = "M/d(E)"

    }

    func toString(format: Format) -> String {
        let f = DateFormatter()
        f.dateStyle = .medium
        f.timeStyle = .medium
        f.locale = Locale(identifier: "ja_JP")
        f.dateFormat = format.rawValue
        return f.string(from: self)
    }

    func convert( format: Format, string: String ) -> Date {
        let f = DateFormatter()
        f.calendar = Calendar(identifier: .gregorian)
        f.dateFormat = format.rawValue
        return f.date(from: string)!
    }
}
