//
//  FavoriteMovieCell.swift
//
//
//  Created by bastian.veliz.vega on 16-05-21.
//

import Core
import SDWebImageSwiftUI
import SwiftUI

struct FavoriteMovieCell: View {
    let model: FavoriteMovieCellModel

    var body: some View {
        HStack {
            WebImage(url: self.model.imageUrl)
                .placeholder(content: {
                    Image(systemName: self.model.systemImageName)
                        .resizable()
                        .padding()
                        .aspectRatio(contentMode: .fit)
                })
                .resizable()
                .frame(maxWidth: 100, maxHeight: 100)
            VStack(alignment: .leading) {
                Text(self.model.movieName)
                Text(self.model.releaseDate)
            }
        }
    }
}

struct FavoriteMovieCell_Previews: PreviewProvider {
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
            List {
                FavoriteMovieCell(model: FavoriteMovieCellModel(model: self.movieModel))
                FavoriteMovieCell(model: FavoriteMovieCellModel(model: self.movieModel))
            }
            VStack {
                FavoriteMovieCell(model: FavoriteMovieCellModel(model: self.movieModel))
                FavoriteMovieCell(model: FavoriteMovieCellModel(model: self.movieModel))
            }
        }
    }
}
