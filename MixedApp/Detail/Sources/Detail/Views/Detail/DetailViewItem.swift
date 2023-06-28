//
//  DetailViewItem.swift
//
//
//  Created by bastian.veliz.vega on 24-04-21.
//

import Core
import Foundation

struct DetailViewItem: Identifiable {
    let id: Int32
    let movieName: String
    let releaseDate: String
    let genres: [String]
    let synopsis: String
    let isFavorite: Bool

    let posterUrl: URL?
    let systemImageName = "film"
    var favoriteImageName: String {
        return self.isFavorite ? "heart.fill" : "heart"
    }
}

extension DetailViewItem {
    init(model: MovieModel, isFavorite: Bool, genres: [String]) {
        self.init(id: model.id,
                  movieName: model.title,
                  releaseDate: model.releaseDate,
                  genres: genres,
                  synopsis: model.synopsis,
                  isFavorite: isFavorite,
                  posterUrl: model.posterUrl)
    }
}
