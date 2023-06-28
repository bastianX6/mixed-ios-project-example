//
//  MovieModel.swift
//
//
//  Created by bastian.veliz.vega on 24-04-21.
//

import Foundation

public struct MovieModel: Identifiable {
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

public extension MovieModel {
    init?(entity: MovieEntity) {
        guard let imgUrl = Configurations.shared?.string(for: .movieDbImageEndpoint),
            let posterUrl = URL(string: imgUrl + entity.posterPath)
        else {
            return nil
        }

        self.init(id: entity.id,
                  title: entity.title,
                  posterUrl: posterUrl,
                  genreIDS: entity.genreIDS,
                  synopsis: entity.overview,
                  releaseDate: entity.releaseDate)
    }

    init(entity: FavoriteMovieEntity) {
        self.init(id: entity.id,
                  title: entity.title,
                  posterUrl: entity.posterUrl,
                  genreIDS: entity.genreIDS,
                  synopsis: entity.synopsis,
                  releaseDate: entity.releaseDate)
    }
}
