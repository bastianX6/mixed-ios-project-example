//
//  NSKeyedArchiverCache.swift
//
//
//  Created by bastian.veliz.vega on 24-04-21.
//

import Foundation

public class NSKeyedArchiverCache: CacheServiceProtocol {
    public init() {}

    public func storeValue<T>(_ value: T, forKey key: CacheKey) throws where T: Codable {
        let objectData = try JSONEncoder().encode(value)
        let archivedData = try NSKeyedArchiver.archivedData(withRootObject: objectData, requiringSecureCoding: true)
        try archivedData.write(to: self.getFilePath(forKey: key))
    }

    public func readValue<T>(forKey key: CacheKey) throws -> T where T: Codable {
        let archivedData = try Data(contentsOf: self.getFilePath(forKey: key))
        guard let objectData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(archivedData) as? Data else {
            throw DecodeError.nilValue
        }

        let decodedValue = try JSONDecoder().decode(T.self, from: objectData)
        return decodedValue
    }

    public func createStorage<T>(_ value: T, forKey key: CacheKey) throws where T: Codable {
        let url = self.getFilePath(forKey: key)
        guard !FileManager.default.fileExists(atPath: url.relativePath) else { return }
        try self.storeValue(value, forKey: key)
    }

    enum DecodeError: Error {
        case nilValue
    }

    private var documentsDirectory: URL = {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }()

    private func getFilePath(forKey key: CacheKey) -> URL {
        let fullPath = self.documentsDirectory.appendingPathComponent(key.rawValue)
        return fullPath
    }
}
