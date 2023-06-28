//
//  ListCellGrid.swift
//
//
//  Created by bastian.veliz.vega on 19-04-21.
//

import SDWebImageSwiftUI
import SwiftUI
import Core

struct ListCellGrid: View {
    var model: ListCellGridModel

    var body: some View {
        VStack {
            WebImage(url: self.model.imageUrl)
                .placeholder(content: {
                    Image(systemName: self.model.systemImageName)
                        .resizable()
                        .padding()
                        .aspectRatio(contentMode: .fit)
                })
                .resizable()
            HStack {
                Text(self.model.movieName)
                Button(action: {}, label: {
                    Image(systemName: self.model.favoriteImageName)
                })
            }
        }
    }
}

struct ListCellGrid_Previews: PreviewProvider {
    static let url: URL = {
        let urlString = "https://picsum.photos/200/300"
        guard let url = URL(string: urlString) else {
            fatalError("Couldn't parse url")
        }
        return url
    }()

    static var movieModel: MovieModel {
        return MovieModel(id: 0,
                          title: "movie title",
                          posterUrl: url,
                          genreIDS: [],
                          synopsis: "Coming soon",
                          releaseDate: "date")
    }

    static var previews: some View {
        Group {
            VStack {
                ListCellGrid(model: ListCellGridModel(model: self.movieModel,
                                                      isFavorite: true))
                ListCellGrid(model: ListCellGridModel(model: self.movieModel,
                                                      isFavorite: true))
            }
            VStack {
                ListCellGrid(model: ListCellGridModel(model: self.movieModel,
                                                      isFavorite: false))
                ListCellGrid(model: ListCellGridModel(model: self.movieModel,
                                                      isFavorite: false))
            }
        }
    }
}
