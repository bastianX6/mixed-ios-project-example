//
//  FavoriteMovieCellModel.swift
//
//
//  Created by bastian.veliz.vega on 16-05-21.
//

import Core
import Foundation

struct FavoriteMovieCellModel: Identifiable {
    let model: MovieModel

    var id: Int32 {
        return self.model.id
    }

    var movieName: String {
        return self.model.title
    }

    var releaseDate: String {
        return self.model.releaseDate
    }

    var imageUrl: URL? {
        return self.model.posterUrl
    }

    let systemImageName = "film"
}
