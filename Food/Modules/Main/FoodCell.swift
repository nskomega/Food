//
//  FoodCell.swift
//  Food
//
//  Created by Mikhail Danilov on 02.06.2023.
//

import UIKit
import Kingfisher

struct FoodCellInput {
    var image: String
    var title: String
}

final class FoodCell: UICollectionViewCell {
    var isPressed: Bool = false {
        didSet {
            isSelected()
        }
    }

    var data: FoodCellInput? {
        didSet {
            guard let data = self.data else { return }

            if let url = URL(string: data.image) {
                setImageURL(url: url)
            }
            mainLabel.text = data.title
        }
    }

    private lazy var backgroundMaskView: UIView = Self.makeBackgroundMaskView()
    private lazy var imageView: UIImageView = Self.makeImageView()
    private lazy var mainLabel: UILabel = Self.makeMainLabel()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        contentView.addSubview(backgroundMaskView)
        backgroundMaskView.edgesToSuperview()

        backgroundMaskView.addSubview(imageView)
        imageView.edgesToSuperview()

        backgroundMaskView.addSubview(mainLabel)
        mainLabel.leftToSuperview(offset: 16)
        mainLabel.rightToSuperview(offset: -16)
        mainLabel.bottomToSuperview(offset: -16)

        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        backgroundMaskView.addSubview(blurEffectView)
        blurEffectView.top(to: mainLabel, offset: -16)
        blurEffectView.leftToSuperview()
        blurEffectView.rightToSuperview()
        blurEffectView.bottomToSuperview()

        backgroundMaskView.bringSubviewToFront(mainLabel)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Factory
extension FoodCell {
    private static func makeBackgroundMaskView() -> UIView {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 25
        return view
    }

    private static func makeImageView() -> UIImageView {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.masksToBounds = true
        image.image = UIImage(named: "noFoto")
        return image
    }

    private static func makeMainLabel() -> UILabel {
        let label = UILabel()
        label.font = Fonts.bold17
        label.textColor = Style.labelColor
        label.numberOfLines = 0
        label.backgroundColor = .clear
        return label
    }

}

// MARK: - Private
extension FoodCell {
    private enum Style {
        static let labelColor: UIColor = ColorScheme.primaryTitleLabelColor
        static let selectedCellColor: UIColor = ColorScheme.selectedCellColor
    }

    private func setImageURL(url: URL) {
        imageView.kf.setImage(with: url) { [weak self] result in
            switch result {
            case .success(_):
                break
            case .failure(_):
                self?.imageView.image = UIImage(named: "noFoto")
            }
        }
    }
}


// MARK: - Utils
extension FoodCell {
    private func isSelected() {
        if isPressed {
            layer.borderColor = Style.selectedCellColor.cgColor
            layer.borderWidth = 3
            layer.cornerRadius = 25
        } else {
            layer.borderColor = UIColor.clear.cgColor
        }
    }
}
