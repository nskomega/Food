//
//  UICollectionView+Utils.swift
//  Food
//
//  Created by Mikhail Danilov on 02.06.2023.
//

import UIKit

extension UICollectionView {
    var widestCellWidth: CGFloat {
        let insets = self.contentInset.left + self.contentInset.right
        return self.bounds.width - insets
    }
}
