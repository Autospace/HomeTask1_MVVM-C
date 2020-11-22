//
//  Defaults.swift
//  HomeTask1_MVVM-C
//
//  Created by Alex Mostovnikov on 22/11/20.
//

import Foundation

public let Defaults = UserDefaults.standard

public enum DefaultKey: String {
    case isLoggedIn
}

extension UserDefaults {
    
    // MARK: - Properties
    public var isLoggedIn: Bool {
        get { return self[.isLoggedIn] ?? false }
        set { self[.isLoggedIn] = newValue }
    }
    
    // MARK: - Support
    private subscript<T: Codable>(key: DefaultKey) -> T? {
        get {
            switch T.self {
            case is String.Type, is Bool.Type, is Date.Type:
                return object(forKey: key.rawValue) as? T
            default:
                if let json = object(forKey: key.rawValue) as? Data {
                    let decoder = JSONDecoder()
                    return try? decoder.decode(T.self, from: json)
                } else {
                    return nil
                }
            }
        }
        set {
            switch T.self {
            case is String.Type, is Bool.Type, is Date.Type:
                set(newValue, forKey: key.rawValue)
            default:
                var json: Data?

                if let value = newValue {
                    let encoder = JSONEncoder()
                    json = try? encoder.encode(value)
                }

                set(json, forKey: key.rawValue)
            }
        }
    }
}
