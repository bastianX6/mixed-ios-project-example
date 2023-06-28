//
//  GenreEntity.swift
//
//
//  Created by bastian.veliz.vega on 12-04-21.
//

import Foundation

public struct GenreEntity: Codable {
    public let id: Int
    public let name: String

    private enum CodingKeys: String, CodingKey {
        case id, name
    }
}
