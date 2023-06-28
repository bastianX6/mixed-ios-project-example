//
//  LoadGenresMiddleware.swift
//
//
//  Created by bastian.veliz.vega on 08-02-22.
//

import Combine
import Core
import Foundation
import ReSwift

class LoadGenresMiddleware {
    let middleware: Middleware<DetailViewStateNew> = { _, _ in
        { next in
            { middlewareAction in

                guard let loadDataAction = middlewareAction as? DetailViewAction.LoadData else {
                    return next(middlewareAction)
                }

                let future = Future<[MovieModel], Error> { promise in
                    do {
                        let favoriteMovies = try loadDataAction.favoritesProvider.getAllFavorites()
                        promise(.success(favoriteMovies))
                    } catch {
                        promise(.failure(error))
                    }
                }

                let cancellable = loadDataAction.provider.getGenres()
                    .zip(future)
                    .receive(on: DispatchQueue.main)
                    .sink { completion in

                        switch completion {
                        case .finished:
                            break
                        case let .failure(error):
                            debugPrint("error: \(error)")
                            let action = DetailViewAction.ShowError(error: error)
                            loadDataAction.store?.dispatch(action)
                        }
                    } receiveValue: { dict, favoriteMovies in
                        let isFavorite = favoriteMovies.contains(where: { $0.id == loadDataAction.movie.id })

                        var genres = [String]()

                        if !dict.isEmpty {
                            loadDataAction.movie.genreIDS.forEach { genreId in
                                if let genreName = dict[genreId] {
                                    genres.append(genreName)
                                }
                            }
                        }

                        let detailItem = DetailViewItem(model: loadDataAction.movie, isFavorite: isFavorite, genres: genres)
                        let action = DetailViewAction.ShowData(detailMovie: detailItem)
                        let favoriteAction = FavoriteMovieActions.UpdateFavoriteStatus(isFavorite: isFavorite)
                        loadDataAction.store?.dispatch(action)
                        loadDataAction.store?.dispatch(favoriteAction)
                    }
                loadDataAction.cancellables.array.append(cancellable)

                return next(middlewareAction)
            }
        }
    }
}
