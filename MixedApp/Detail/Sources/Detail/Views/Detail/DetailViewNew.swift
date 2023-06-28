//
//  DetailViewNew.swift
//
//
//  Created by bastian.veliz.vega on 08-02-22.
//

import Core
import SDWebImageSwiftUI
import SwiftUI
import UIComponents

extension String: Identifiable {
    public var id: String {
        return self
    }
}

struct DetailViewNew: View {
    @ObservedObject var viewModel: DetailViewModelStore

    init(viewModel: DetailViewModelStore) {
        self.viewModel = viewModel
    }

    var body: some View {
        self.contentView
            .onAppear {
                self.viewModel.loadData()
            }
    }

    @ViewBuilder var contentView: some View {
        switch self.viewModel.viewState.state {
        case .loading:
            LoadingView()
        case let .withData(detailMovie):
            self.getDetailView(item: detailMovie)
        case let .withError(error):
            GenericErrorView(title: L10n.error, error: error)
        }
    }

    private func getDetailView(item: DetailViewItem) -> some View {
        ScrollView {
            VStack {
                WebImage(url: item.posterUrl)
                    .placeholder(content: {
                        Image(systemName: item.systemImageName)
                            .resizable()
                            .padding()
                            .aspectRatio(contentMode: .fit)
                    })
                    .resizable()
                VStack(alignment: .leading) {
                    Text(item.movieName)
                    Divider()
                    Text(item.releaseDate)
                    Divider()
                    VStack {
                        ForEach(item.genres) { genre in
                            Text(genre)
                        }
                    }
                    Divider()
                    Text(item.synopsis)
                        .italic()
                }
                .padding([.leading, .trailing])
            }
        }
    }
}
