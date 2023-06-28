//
//  MovieDBApiError.swift
//
//
//  Created by bastian.veliz.vega on 12-04-21.
//

import Foundation

public struct MovieDBApiError: Codable, Error {
    public let statusMessage: String
    public let statusCode: Int

    private enum CodingKeys: String, CodingKey {
        case statusMessage = "status_message"
        case statusCode = "status_code"
    }
}
