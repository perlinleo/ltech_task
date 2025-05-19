//
//  PostDTO.swift
//  ltech
//
//  Created by blacksnow on 5/16/25.
//
import Foundation

struct PostDTO: Decodable {
    let id: String
    let title: String
    let text: String
    let image: String
    let sort: Int
    let date: Date

    enum CodingKeys: String, CodingKey {
        case id, title, text, image, sort, date
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        text = try container.decode(String.self, forKey: .text)
        image = try container.decode(String.self, forKey: .image)
        sort = try container.decode(Int.self, forKey: .sort)

        let dateString = try container.decode(String.self, forKey: .date)
        let formatter = ISO8601DateFormatter()

        guard let parsedDate = formatter.date(from: dateString) else {
            throw DecodingError.dataCorruptedError(
                forKey: .date,
                in: container,
                debugDescription: "Expected ISO 8601 date string"
            )
        }

        date = parsedDate
    }
}
