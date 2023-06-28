//
//  PopularMoviesResponse.swift
//
//
//  Created by bastian.veliz.vega on 12-04-21.
//

import Foundation

public struct PopularMoviesResponse: Codable {
    public let page: Int
    public let totalResults: Int
    public let totalPages: Int
    public let results: [MovieEntity]

    private enum CodingKeys: String, CodingKey {
        case page, results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
