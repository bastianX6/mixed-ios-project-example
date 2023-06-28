//
//  Configurations.swift
//
//
//  Created by bastian.veliz.vega on 12-04-21.
//

import Foundation

enum ConfigurationsKeys: String {
    case movieDbApiKey = "MOVIEDB_APIKEY"
    case movieDbApiEndpoint = "MOVIEDB_ENDPOINT"
    case movieDbImageEndpoint = "MOVIEDB_IMG_ENDPOINT"
    case movieDBLanguage = "MOVIEDB_LANGUAGE"
}

protocol ConfigurationsProtocol {
    func string(for key: ConfigurationsKeys) -> String?
}

class Configurations: ConfigurationsProtocol {
    static let shared = Configurations()
    private var properties: [String: Any]

    init?() {
        guard let path = Bundle.module.path(forResource: "Configurations", ofType: "plist"),
            let xml = FileManager.default.contents(atPath: path),
            let propertyAny = try? PropertyListSerialization.propertyList(from: xml,
                                                                          options: .mutableContainersAndLeaves,
                                                                          format: nil),
            let propertyDict = propertyAny as? [String: Any]
        else {
            return nil
        }
        self.properties = propertyDict
    }

    func string(for key: ConfigurationsKeys) -> String? {
        return self.properties[key.rawValue] as? String
    }
}
