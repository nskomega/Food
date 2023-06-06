//
//  MainRouter.swift
//  Food
//
//  Created by Mikhail Danilov on 02.06.2023.
//

import Foundation
import UIKit

final class MainRouter: NSObject, Router {
    enum Destination {
        case error(String?, String?)
    }

    weak var navigationContext: UIViewController?

    func navigate(to destination: Destination) {
        switch destination {
        case .error(let title, let message):
            self.showAlert(title: title, message: message)
        }
    }
}

extension MainRouter {
    private func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.navigationContext?.present(alert, animated: true, completion: nil)
    }
}
