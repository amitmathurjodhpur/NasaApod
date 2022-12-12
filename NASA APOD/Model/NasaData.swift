//
//  NasaData.swift
//  NASA APOD
//
//  Created by Amit Mathur on 12/12/22.
//

import Foundation

struct Products: Codable {
    let products: [NasaData]?
}

struct NasaData: Decodable {
    let copyright: String?
    let date: String
    let explanation: String
    let hdurl: String
    let media_type: String
    let service_version: String
    let title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case copyright = "copyright"
        case date = "date"
        case explanation = "explanation"
        case hdurl = "hdurl"
        case media_type = "media_type"
        case service_version = "service_version"
        case title = "title"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.copyright = try values.decodeIfPresent(String.self, forKey: .copyright)
        self.date = try values.decode(String.self, forKey: .date)
        self.explanation = try values.decode(String.self, forKey: .explanation)
        self.hdurl = try values.decode(String.self, forKey: .hdurl)
        self.media_type = try values.decode(String.self, forKey: .media_type)
        self.service_version = try values.decode(String.self, forKey: .service_version)
        self.title = try values.decode(String.self, forKey: .title)
        self.url = try values.decode(String.self, forKey: .url)
    }
}
extension NasaData: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.copyright, forKey: .copyright)
        try container.encodeIfPresent(self.date, forKey: .date)
        try container.encodeIfPresent(self.explanation, forKey: .explanation)
        try container.encodeIfPresent(self.hdurl, forKey: .hdurl)
        try container.encodeIfPresent(self.media_type, forKey: .media_type)
        try container.encodeIfPresent(self.service_version, forKey: .service_version)
        try container.encodeIfPresent(self.title, forKey: .title)
        try container.encodeIfPresent(self.url, forKey: .url)
    }
}
