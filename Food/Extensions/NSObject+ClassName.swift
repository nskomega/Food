//
//  NSObject+ClassName.swift
//  Food
//
//  Created by Mikhail Danilov on 02.06.2023.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }

    class var className: String {
        return String(describing: self)
    }
}
