//
//  NetworkClient.swift
//
//
//  Created by bastian.veliz.vega on 12-04-21.
//

import Alamofire
import Combine
import Foundation

public protocol MovieDBCloudServiceProtocol {
    func getMovieList(page: Int?,
                      language: String?) -> AnyPublisher<PopularMoviesResponse, Error>

    func getGenreList(language: String?) -> AnyPublisher<GenreListResponse, Error>
}

public class MovieDBCloudService: MovieDBCloudServiceProtocol {
    public init() {}

    public func getMovieList(page: Int?,
                             language: String?) -> AnyPublisher<PopularMoviesResponse, Error>
    {
        guard let apiUrl = Configurations.shared?.string(for: .movieDbApiEndpoint),
            let apiKey = Configurations.shared?.string(for: .movieDbApiKey),
            let url = URL(string: apiUrl + Endpoint.popularMovies.rawValue)
        else {
            return Fail<PopularMoviesResponse, Error>(error: MovieDBCloudSourceError.badURL).eraseToAnyPublisher()
        }
        var parameters: [String: Any] = [
            "api_key": apiKey,
        ]
        if let page = page {
            parameters["page"] = page
        }

        if let language = language {
            parameters["language"] = language
        } else if let configLanguage = Configurations.shared?.string(for: .movieDBLanguage) {
            parameters["language"] = configLanguage
        }

        return self.request(url: url, parameters: parameters)
    }

    public func getGenreList(language: String?) -> AnyPublisher<GenreListResponse, Error> {
        guard let apiUrl = Configurations.shared?.string(for: .movieDbApiEndpoint),
            let apiKey = Configurations.shared?.string(for: .movieDbApiKey),
            let url = URL(string: apiUrl + Endpoint.genreList.rawValue)
        else {
            return Fail<GenreListResponse, Error>(error: MovieDBCloudSourceError.badURL).eraseToAnyPublisher()
        }

        var parameters: [String: Any] = [
            "api_key": apiKey,
        ]

        if let language = language {
            parameters["language"] = language
        } else if let configLanguage = Configurations.shared?.string(for: .movieDBLanguage) {
            parameters["language"] = configLanguage
        }

        return self.request(url: url, parameters: parameters)
    }

    private func request<T: Decodable>(url: URL, parameters: [String: Any]) -> AnyPublisher<T, Error> {
        return AF.request(url,
                          method: .get,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: nil)
            .validate()
            .publishDecodable(type: T.self)
            .value()
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
}

enum MovieDBCloudSourceError: Error {
    case badURL, parseError
}
