/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Your name (e.g. Nguyen Van Minh)
  ID: Your student id (e.g. 1234567)
  Created  date: dd/mm/yyyy (e.g. 31/07/2022)
  Last modified: dd/mm/yyyy (e.g. 05/08/2022)
  Acknowledgement: Acknowledge the resources that you use here.
*/

import Foundation


// MARK: - Welcome
struct Welcome: Codable {
    var data: [Datum]
    var meta: WelcomeMeta
    var links: WelcomeLinks
}

// MARK: - Datum
struct Datum: Codable {
    var id: String
    var attributes: Attributes
    var isFavorite: Bool?
}

// MARK: - Attributes
struct Attributes: Codable {
    let createdAt: String
    //let updatedAt: UpdatedAt
    let slug, synopsis, attributesDescription: String
    let coverImageTopOffset: Int
    let titles: Titles
    let canonicalTitle: String
    let abbreviatedTitles: [String]
    let averageRating: String?
    let ratingFrequencies: [String: String]
    let userCount, favoritesCount: Int
    let startDate, endDate: String?
    let nextRelease: JSONNull?
    let popularityRank: Int
    let ratingRank: Int?
    let ageRating, ageRatingGuide: String?
    let subtype: TypeEnum
    let status: Status
    let tba: String?
    let posterImage: PosterImage
    let coverImage: CoverImage?
    let chapterCount: Int?
    let volumeCount: Int
    let serialization: String?
    let mangaType: TypeEnum

    enum CodingKeys: String, CodingKey {
        case createdAt, slug, synopsis
        case attributesDescription = "description"
        case coverImageTopOffset, titles, canonicalTitle, abbreviatedTitles, averageRating, ratingFrequencies, userCount, favoritesCount, startDate, endDate, nextRelease, popularityRank, ratingRank, ageRating, ageRatingGuide, subtype, status, tba, posterImage, coverImage, chapterCount, volumeCount, serialization, mangaType
    }
}

// MARK: - CoverImage
struct CoverImage: Codable {
    let tiny, large, small: String
    let tinyWebp, largeWebp, smallWebp: String
    let original: String
    let meta: CoverImageMeta

    enum CodingKeys: String, CodingKey {
        case tiny, large, small
        case tinyWebp = "tiny_webp"
        case largeWebp = "large_webp"
        case smallWebp = "small_webp"
        case original, meta
    }
}

// MARK: - CoverImageMeta
struct CoverImageMeta: Codable {
    let dimensions: PurpleDimensions
}

// MARK: - PurpleDimensions
struct PurpleDimensions: Codable {
    let tiny, large, small, tinyWebp: Large
    let largeWebp, smallWebp: Large

    enum CodingKeys: String, CodingKey {
        case tiny, large, small
        case tinyWebp = "tiny_webp"
        case largeWebp = "large_webp"
        case smallWebp = "small_webp"
    }
}

// MARK: - Large
struct Large: Codable {
    let width, height: Int
}

enum TypeEnum: String, Codable {
    case manga = "manga"
}

// MARK: - PosterImage
struct PosterImage: Codable {
    let tiny, large, small, medium: String
    let original: String
    let meta: PosterImageMeta
}

// MARK: - PosterImageMeta
struct PosterImageMeta: Codable {
    let dimensions: FluffyDimensions
}

// MARK: - FluffyDimensions
struct FluffyDimensions: Codable {
    let tiny, large, small, medium: Large
}

enum Status: String, Codable {
    case current = "current"
    case finished = "finished"
    case tba = "tba"
}

// MARK: - Titles
struct Titles: Codable {
    let en: String?
    let enJp: String
    let enUs, jaJp: String?

    enum CodingKeys: String, CodingKey {
        case en
        case enJp = "en_jp"
        case enUs = "en_us"
        case jaJp = "ja_jp"
    }
}

//enum UpdatedAt: String, Codable {
//    case the20220722T060011223Z = "2022-07-22T06:00:11.223Z"
//    case the20220722T060837478Z = "2022-07-22T06:08:37.478Z"
//}

// MARK: - DatumLinks
struct DatumLinks: Codable {
    let linksSelf: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

// MARK: - Relationship
struct Relationship: Codable {
    let links: RelationshipLinks
}

// MARK: - RelationshipLinks
struct RelationshipLinks: Codable {
    let linksSelf, related: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case related
    }
}

// MARK: - WelcomeLinks
struct WelcomeLinks: Codable {
    let first, next, last: String
}

// MARK: - WelcomeMeta
struct WelcomeMeta: Codable {
    let count: Int
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
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

let url = URL(string: "https://kitsu.io/api/edge/manga")!
var request = URLRequest(url: url)

class apiCall {
    func getMangaList(completion:@escaping ([Datum]) -> ()) {
        guard URL(string: "https://kitsu.io/api/edge/manga") != nil else { return }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response {
                print(response)
                if let data = data, let body = String(data: data, encoding: .utf8) {
                    let attributes = try! JSONDecoder().decode(Welcome.self, from: data)
                    let name = attributes.data
                    DispatchQueue.main.async {
                        completion(name)
                    }
                }
            } else {
                print(error ?? "Unknown error")
            }
        }.resume()
    }
}
