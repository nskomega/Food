//
//  MainViewModel.swift
//  Food
//
//  Created by Mikhail Danilov on 02.06.2023.
//

import Foundation

protocol MainPresenterDelegate: AnyObject {
    func mainPresenter(_ presenter: MainPresenter, didUpdate data: MainViewControllerInput)
    func mainPresenter(_ presenter: MainPresenter, showErrorWith title: String?, description: String)
}

final class MainPresenter {
    // MARK: Properties
    private let loader = LoaderJson()
    private(set) var data: MainViewControllerInput
    private(set) var sections: [Section]

    weak var delegate: MainPresenterDelegate?

    init() {
        data = .init(sections: [:], sectionNames: [])
        sections = []
    }

    // MARK: Methods
    func fetchData() {
        loader.load { [weak self] result in
            switch result {
            case .success(let food):
                self?.handleSuccess(food)
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
    }
}

// MARK: - Private
extension MainPresenter {
    private func handleSuccess(_ food: Food) {

        sections = food.sections
        for section in food.sections {
            data.sectionNames.append(section.header)
            data.sections[section.header] = section.items.map { item in
                FoodCellInput(image: item.image.url, title: item.title)
            }
        }
        delegate?.mainPresenter(self, didUpdate: data)
    }

    private func handleError(error: Error) {
        delegate?.mainPresenter(self, showErrorWith: "Error", description: error.localizedDescription)
    }
}
