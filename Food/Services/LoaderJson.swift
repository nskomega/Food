//
//  LoaderJson.swift
//  Food
//
//  Created by Mikhail Danilov on 02.06.2023.
//

import Foundation

enum JsonError: Error {
    case notFound
    case unhandled(Error)
}

class LoaderJson {
    func load(completion: @escaping (Result<Food, JsonError>) -> Void) {
        guard let jsonURL = Bundle.main.url(forResource: "data", withExtension: "json") else {
            completion(.failure(.notFound))
            return
        }

        do {
            let jsonData = try Data(contentsOf: jsonURL)
            let food = try JSONDecoder().decode(Food.self, from: jsonData)
            completion(.success(food))
        } catch {
            completion(.failure(.unhandled(error)))
        }
    }
}
