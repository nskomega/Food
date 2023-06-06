//
//  Colors.swift
//  Food
//
//  Created by Mikhail Danilov on 02.06.2023.
//

import Foundation
import UIKit

private enum Palette {
    static let darkGray = UIColor(hexString: "3A3B3D")
    static let liteGray = UIColor(hexString: "c0c0c0")
    static let blue = UIColor(hexString: "8292FB")
}

public enum ColorScheme {
    static let mainbackgroundColor: UIColor = Palette.liteGray
    static let primaryTitleLabelColor: UIColor = Palette.darkGray
    static let selectedCellColor: UIColor = Palette.blue
}
