//
//  FavoritesListView.swift
//
//
//  Created by bastian.veliz.vega on 16-05-21.
//

import Core
import Detail
import SwiftUI
import UIComponents

struct FavoritesListView: View {
    @ObservedObject var viewModel: FavoritesListViewModel

    init(viewModel: FavoritesListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        self.contentView.onAppear(perform: {
            self.viewModel.loadMovies()
        })
    }

    @ViewBuilder var contentView: some View {
        switch self.viewModel.viewState {
        case let .error(error):
            GenericErrorView(title: "", error: error)
        case let .withData(data):
            if data.isEmpty {
                self.emptyStateView
            } else {
                List {
                    ForEach(data) { listModel in
                        FavoriteMovieCell(model: listModel).onTapGesture {
                            self.viewModel.didTapCell(movie: listModel.model)
                        }
                    }
                }
            }

        case .loading:
            LoadingView()
        }
    }

    var emptyStateView: some View {
        Text(L10n.noMovies)
    }
}
