//
//  Food.swift
//  Food
//
//  Created by Mikhail Danilov on 02.06.2023.
//

import Foundation
import UIKit

// MARK: - Food
struct Food: Codable {
    let sections: [Section]
}

// MARK: - Section
struct Section: Codable {
    let id, header: String
    let itemsTotal, itemsToShow: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let id: String
    let image: Image
    let title: String
}

// MARK: - Image
struct Image: Codable {
    let the1X: String
    let the2X: String
    let the3X: String
    let aspectRatio: Double?
    let loopAnimation: Bool?

    private enum CodingKeys: String, CodingKey {
        case the1X = "1x", the2X = "2x", the3X = "3x", aspectRatio, loopAnimation
    }

    var url: String {
        let scale = UIScreen.main.scale
        if scale == 3.0 {
            return the3X
        } else {
            if scale == 2.0 {
                return the2X
            } else {
                return the1X
            }
        }
    }
}
