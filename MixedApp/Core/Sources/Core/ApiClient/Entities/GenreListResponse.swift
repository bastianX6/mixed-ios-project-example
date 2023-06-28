//
//  GenreListResponse.swift
//
//
//  Created by bastian.veliz.vega on 12-04-21.
//

import Foundation

public struct GenreListResponse: Codable {
    public let genres: [GenreEntity]

    private enum CodingKeys: String, CodingKey {
        case genres
    }
}
