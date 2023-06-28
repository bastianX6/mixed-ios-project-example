//
//  FavoriteMovieList.swift
//
//
//  Created by bastian.veliz.vega on 30-04-21.
//

import Foundation

public struct FavoriteMovieList: Codable {
    public let movies: [FavoriteMovieEntity]

    public init(movies: [FavoriteMovieEntity]) {
        self.movies = movies
    }
}
