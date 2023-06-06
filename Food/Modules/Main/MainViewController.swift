//
//  MainViewController.swift
//  Food
//
//  Created by Mikhail Danilov on 02.06.2023.
//

import UIKit
import TinyConstraints

struct MainViewControllerInput {
    var sections: [String: [FoodCellInput]]
    var sectionNames: [String]
}

final class MainViewController: UIViewController {
    private let presenter: MainPresenter
    private let router: MainRouter

    private lazy var collectionView: UICollectionView = Self.makeCollectionView()

    init(presenter: MainPresenter, router: MainRouter) {
        self.presenter = presenter
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.fetchData()
        router.navigationContext = self
        presenter.delegate = self

        view.backgroundColor = Style.mainBaclgroundColor

        let contentView = UIView()
        contentView.backgroundColor = Style.mainBaclgroundColor
        view.addSubview(contentView)
        contentView.edgesToSuperview()

        view.addSubview(collectionView)
        collectionView.topToSuperview(usingSafeArea: true)
        collectionView.leftToSuperview(offset: 16)
        collectionView.rightToSuperview(offset: -16)
        collectionView.bottomToSuperview(usingSafeArea: true)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - Factory
extension MainViewController {
    private static func makeCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(145), heightDimension: .absolute(180))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 14)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.52), heightDimension: .absolute(180))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            group.interItemSpacing = .fixed(16)
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(70))
            let headerKind = UICollectionView.elementKindSectionHeader
            let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: headerKind, alignment: .top)
            section.boundarySupplementaryItems = [headerElement]
            return section
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HeaderView.self, kind: UICollectionView.elementKindSectionHeader)
        collectionView.register(FoodCell.self)
        collectionView.backgroundColor = Style.mainBaclgroundColor
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        presenter.data.sectionNames.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.data.sections[presenter.data.sectionNames[section]]?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FoodCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        let key = presenter.data.sectionNames[indexPath.section]
        cell.data = presenter.data.sections[key]?[indexPath.row]
        return cell
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath
    ) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? FoodCell else { return }
        if cell.isPressed == true {
            cell.isPressed = false
        } else {
            cell.isPressed = true
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        didDeselectItemAt indexPath: IndexPath
    ) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? FoodCell else { return }
        cell.isPressed = false
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView: HeaderView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                forIndexPath: indexPath
            )
            headerView.mainLabel.text = presenter.data.sectionNames[indexPath.section]
            return headerView
        }
        return UICollectionReusableView()
    }
}

extension MainViewController: MainPresenterDelegate {
    func mainPresenter(_ presenter: MainPresenter, didUpdate data: MainViewControllerInput) {
        updateUI(with: data)
    }

    func mainPresenter(_ presenter: MainPresenter, showErrorWith title: String?, description: String) {
        router.navigate(to: .error(title, description))
    }
}

// MARK: - Utils
extension MainViewController {
    private func updateUI(with data: MainViewControllerInput) {
        collectionView.reloadData()
    }
}

// MARK: - Private
extension MainViewController {
    private enum Style {
        static let mainBaclgroundColor: UIColor = ColorScheme.mainbackgroundColor
    }
}
