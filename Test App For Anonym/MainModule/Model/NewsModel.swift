//
//  NewsModel.swift
//  Test App For Anonym
//
//  Created by Тимур Фатулоев on 21.09.2020.
//  Copyright © 2020 Тимур Фатулоев. All rights reserved.
//

import Foundation

class Response: Codable {
    let data: NewsData?
    let errors: JSONNull?
}

class NewsData: Codable {
    let items: [News]?
    let cursor: String?
}

class News: Codable {
    let id: String?
    let contents: [Content]?
    let language: Language?
    let awards: Awards?
    let createdAt: Int?
    let updatedAt: Int?
    let page: JSONNull?
    let author: Author?
    let stats: Stats?
    let isMyFavorite: Bool?
    
    func createdAt(timeIntervalSince1970: Int) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "ru")
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        dateFormatter.timeZone = .current
        let date = Date(timeIntervalSince1970: TimeInterval(timeIntervalSince1970))
        
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
}

// MARK: - Author
struct Author: Codable {
    let id: String?
    let url: JSONNull?
    let name: String?
    let banner, photo: Banner?
    let gender: Gender?
    let isHidden, isBlocked, isMessagingAllowed: Bool?
    let auth: Auth?
    let statistics: Statistics?
    let tagline: String?
    let data: AuthorData?
}


// MARK: - AuthorData
struct AuthorData: Codable {
}

enum Gender: String, Codable {
    case female = "FEMALE"
    case male = "MALE"
    case unset = "UNSET"
}

// MARK: - Statistics
struct Statistics: Codable {
    let likes, thanks: Int?
    let uniqueName: Bool?
    let thanksNextLevel: Int?
}

// MARK: - Auth
struct Auth: Codable {
    let rocketID: String?
    let isDisabled: Bool?
    let level: Int?

    enum CodingKeys: String, CodingKey {
        case rocketID = "rocketId"
        case isDisabled, level
    }
}

// MARK: - Content
class Content: Codable {
    let type: BannerType?
    let id: String?
    let data: ContentData?
}


// MARK: - Awards
struct Awards: Codable {
    let recent, statistics: [JSONAny]?
    let voices: Int?
    let awardedByMe: Bool?
}

// MARK: - Banner

// MARK: Banner
struct Banner: Codable {
    let type: BannerType?
    let id: String?
    let data: BannerData?
}

// MARK: BannerData
struct BannerData: Codable {
    let extraSmall: ExtraSmall?
    let small: ExtraSmall?
    let original: ExtraSmall?
}

// MARK: - ExtraSmall
struct ExtraSmall: Codable {
    let url: String?
    let size: Size?
}

// MARK: - Size
struct Size: Codable {
    let width: Int?
    let height: Int?
}

enum BannerType: String, Codable {
    case image = "IMAGE"
    case tags = "TAGS"
    case text = "TEXT"
}

// MARK: - ContentData
class ContentData: Codable {
    let extraSmall, small: ExtraSmall?
    let value: String?
    let values: [String]?
    let medium: ExtraSmall?
}

enum Language: String, Codable {
    case en = "en"
}

// MARK: - Stats
struct Stats: Codable {
    let likes: Comments?
    let views: Comments?
    let comments: Comments?
    let shares: Comments?
    let replies: Comments?
    let timeLeftToSpace: Comments?
}

// MARK: - Comments
struct Comments: Codable {
    let count: Int?
    let my: Bool?
}

// MARK: - Encode/decode helpers
class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
