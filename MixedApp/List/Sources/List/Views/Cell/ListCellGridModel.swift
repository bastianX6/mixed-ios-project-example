//
//  ListCellGridModel.swift
//
//
//  Created by bastian.veliz.vega on 19-04-21.
//

import Core
import Foundation

struct ListCellGridModel: Identifiable {
    let model: MovieModel
    var isFavorite: Bool

    var id: Int32 {
        return self.model.id
    }

    var movieName: String {
        return self.model.title
    }

    var imageUrl: URL? {
        return self.model.posterUrl
    }

    let systemImageName = "film"
    var favoriteImageName: String {
        return self.isFavorite ? "heart.fill" : "heart"
    }
}
