//
//  HeaderView.swift
//  Food
//
//  Created by Mikhail Danilov on 02.06.2023.
//

import UIKit

final class HeaderView: UICollectionReusableView {
    private(set) lazy var mainLabel: UILabel = Self.makeMainLabel()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        addSubview(mainLabel)
        mainLabel.edgesToSuperview(insets: .init(top: 16, left: 0, bottom: 16, right: 8))
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Factory
extension HeaderView {
    private static func makeMainLabel() -> UILabel {
        let label = UILabel()
        label.font = Fonts.heavy28
        label.textColor = Style.labelColor
        label.numberOfLines = 0
        label.backgroundColor = .clear
        return label
    }
}

// MARK: - Private
extension HeaderView {
    private enum Style {
        static let labelColor: UIColor = ColorScheme.primaryTitleLabelColor
    }
}
