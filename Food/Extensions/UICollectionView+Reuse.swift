//
//  UICollectionView+Reuse.swift
//  Food
//
//  Created by Mikhail Danilov on 02.06.2023.
//

import UIKit.UICollectionView

extension UICollectionView {
    func register<CollectionViewCell: UICollectionViewCell>(_ cellType: CollectionViewCell.Type, with identifier: String? = nil) {
        let identifier = identifier ?? CollectionViewCell.className
        self.register(cellType, forCellWithReuseIdentifier: identifier)
    }

    func dequeueReusableCell<CollectionViewCell: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> CollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: CollectionViewCell.className, for: indexPath) as? CollectionViewCell else {
            fatalError("Failed to dequeue a reausable cell")
        }

        return cell
    }

    func register<SupplementaryView: UICollectionReusableView>(_ viewType: SupplementaryView.Type, kind: String, with identifier: String? = nil) {
        let identifier = identifier ?? SupplementaryView.className
        self.register(viewType, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
    }

    func dequeueReusableSupplementaryView<SupplementaryView: UICollectionReusableView>(
        ofKind kind: String,
        forIndexPath indexPath: IndexPath
    ) -> SupplementaryView {
        guard
            let view = dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SupplementaryView.className,
                for: indexPath
            ) as? SupplementaryView
        else {
            fatalError("Failed to dequeue a reausable supplementary view")
        }

        return view
    }
}
