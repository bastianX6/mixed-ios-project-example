//
//  CacheServiceProtocol.swift
//
//
//  Created by bastian.veliz.vega on 24-04-21.
//

import Foundation

public protocol CacheServiceProtocol {
    func storeValue<T: Codable>(_ value: T, forKey key: CacheKey) throws
    func readValue<T: Codable>(forKey key: CacheKey) throws -> T
    func createStorage<T: Codable>(_ value: T, forKey key: CacheKey) throws
}
