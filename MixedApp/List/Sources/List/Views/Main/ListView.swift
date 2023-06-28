//
//  ListView.swift
//
//
//  Created by bastian.veliz.vega on 19-04-21.
//

import Core
import Detail
import SwiftUI
import UIComponents

struct ListView: View {
    @ObservedObject var viewModel: ListViewModel

    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        self.contentView.onAppear(perform: {
            self.viewModel.loadFirstItems()
        })
    }

    @ViewBuilder var contentView: some View {
        switch self.viewModel.viewState {
        case let .error(error):
            GenericErrorView(title: "", error: error)
        case .withData:
            self.listView
        case .loading:
            LoadingView()
        }
    }

    var listView: some View {
        let columns = [
            GridItem(.adaptive(minimum: 150)),
        ]

        return ScrollView {
            LazyVGrid(columns: columns,
                      spacing: 8,
                      pinnedViews: [],
                      content: {
                          ForEach(self.viewModel.listItems) { gridModel in
                              self.getGridElement(gridModel: gridModel)
                          }
                      })
        }
    }

    func getGridElement(gridModel: ListCellGridModel) -> some View {
        let gridView = ListCellGrid(model: gridModel)

        return gridView
            .frame(maxHeight: 230)
            .onAppear {
                self.viewModel.loadNewItemsIfNeeded(model: gridModel.model)
            }
            .onTapGesture {
                self.viewModel.didTapCell(movie: gridModel.model)
            }
    }
}

import Combine
struct ListView_Previews: PreviewProvider {
    class MockFavoriteProvider: FavoritesProviderProtocol {
        func addAsFavorite(movie _: MovieModel) throws {}
        func removeAsFavorite(movie _: MovieModel) throws {}
        func getAllFavorites() throws -> [MovieModel] {
            return []
        }
    }

    class MockProvider: ListDataProviderProtocol {
        enum MockError: Error {
            case mock
        }

        var shouldFail: Bool = false

        func getMovieList(page _: Int?, language _: String?) -> AnyPublisher<MovieList, Error> {
            let url = URL(string: "www.google.cl")!
            let model = MovieModel(id: 0,
                                   title: "movie title",
                                   posterUrl: url,
                                   genreIDS: [],
                                   synopsis: "Coming soon",
                                   releaseDate: "date")

            let movieList = MovieList(currentPage: 1,
                                      totalPages: 10,
                                      movies: [
                                          model,
                                          model,
                                          model,
                                      ])

            let future =
                Deferred {
                    Future<MovieList, Error> { promise in
                        if self.shouldFail {
                            promise(.failure(MockError.mock))
                        } else {
                            promise(.success(movieList))
                        }
                    }
                }

            return future.eraseToAnyPublisher()
        }
    }

    static let viewModel: ListViewModel = {
        let provider = MockProvider()
        let viewModel = ListViewModel(provider: provider,
                                      favoritesProvider: MockFavoriteProvider())
        return viewModel
    }()

    static let viewModelFail: ListViewModel = {
        let provider = MockProvider()
        provider.shouldFail = true
        let viewModel = ListViewModel(provider: provider,
                                      favoritesProvider: MockFavoriteProvider())
        return viewModel
    }()

    static var previews: some View {
        Group {
            ListView(viewModel: self.viewModel)
            ListView(viewModel: self.viewModelFail)
        }
    }
}
