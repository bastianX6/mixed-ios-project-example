//
//  ListDataProvider.swift
//
//
//  Created by bastian.veliz.vega on 19-04-21.
//

import Combine
import Foundation
import Core

protocol ListDataProviderProtocol {
    func getMovieList(page: Int?,
                      language: String?) -> AnyPublisher<MovieList, Error>
}

class ListDataProvider: ListDataProviderProtocol {
    private let service: MovieDBCloudServiceProtocol

    init(service: MovieDBCloudServiceProtocol) {
        self.service = service
    }

    func getMovieList(page: Int?,
                      language: String?) -> AnyPublisher<MovieList, Error>
    {
        return self.service
            .getMovieList(page: page,
                          language: language)
            .map { response in
                MovieList(currentPage: response.page,
                          totalPages: response.totalPages,
                          movies: response.results.compactMap { MovieModel(entity: $0) })
            }
            .eraseToAnyPublisher()
    }
}
