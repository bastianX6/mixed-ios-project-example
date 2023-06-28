//
//  MovieEntity.swift
//
//
//  Created by bastian.veliz.vega on 12-04-21.
//

import Foundation

public struct MovieEntity: Codable {
    public let voteCount: Int?
    public let id: Int32
    public let video: Bool
    public let voteAverage: Double
    public let title: String
    public let popularity: Double
    public let posterPath: String
    public let originalLanguage: String
    public let originalTitle: String
    public let genreIDS: [Int]
    public let backdropPath: String?
    public let adult: Bool
    public let overview: String
    public let releaseDate: String

    private enum CodingKeys: String, CodingKey {
        case id, video, title, popularity, adult, overview
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
    }
}
