//
//  MovieList.swift
//
//
//  Created by bastian.veliz.vega on 24-04-21.
//

import Foundation

public struct MovieList {
    public let currentPage: Int
    public let totalPages: Int
    public let movies: [MovieModel]

    public init(currentPage: Int,
                totalPages: Int,
                movies: [MovieModel])
    {
        self.currentPage = currentPage
        self.totalPages = totalPages
        self.movies = movies
    }
}
