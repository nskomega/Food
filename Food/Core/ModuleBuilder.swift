//
//  ModuleBuilder.swift
//  Food
//
//  Created by Mikhail Danilov on 02.06.2023.
//

import UIKit

class ModuleBuilder {

    static func mainVC() -> UIViewController {
        let router = MainRouter()
        let presenter = MainPresenter()
        let viewController = MainViewController(presenter: presenter, router: router)
        viewController.view.backgroundColor = .white
        return viewController
    }
}
