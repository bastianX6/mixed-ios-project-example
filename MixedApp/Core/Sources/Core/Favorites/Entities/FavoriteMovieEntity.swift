//
//  FavoriteMovieEntity.swift
//
//
//  Created by bastian.veliz.vega on 26-04-21.
//

import Foundation

public struct FavoriteMovieEntity: Codable {
    public let id: Int32
    public let title: String
    public let posterUrl: URL
    public let genreIDS: [Int]
    public let synopsis: String
    public let releaseDate: String

    public init(id: Int32,
                title: String,
                posterUrl: URL,
                genreIDS: [Int],
                synopsis: String,
                releaseDate: String)
    {
        self.id = id
        self.title = title
        self.posterUrl = posterUrl
        self.genreIDS = genreIDS
        self.synopsis = synopsis
        self.releaseDate = releaseDate
    }
}

public extension FavoriteMovieEntity {
    init(model: MovieModel) {
        self.init(id: model.id,
                  title: model.title,
                  posterUrl: model.posterUrl,
                  genreIDS: model.genreIDS,
                  synopsis: model.synopsis,
                  releaseDate: model.releaseDate)
    }
}
