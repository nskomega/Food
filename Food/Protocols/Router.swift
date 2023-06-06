//
//  Router.swift
//  Food
//
//  Created by Mikhail Danilov on 02.06.2023.
//

import Foundation

protocol Router {
    associatedtype Destination

    func navigate(to destination: Destination)
}
