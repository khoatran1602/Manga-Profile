/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 1
 Author: Tran Dang Khoa
 ID: 3847766
 Created  date: 07/11/2022
 Last modified: 08/07/2022
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

//Get Manga List from API
class apiCall {
    func getMangaList(completion:@escaping ([Datum]) -> ()) {
        guard URL(string: "https://kitsu.io/api/edge/manga") != nil else { return }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            //Check if response is nil or not. If nil, print error
            if let response = response {
                print(response)
                if let data = data, let _ = String(data: data, encoding: .utf8) {
                    //Decode json to take the manga's name
                    let attributes = try! JSONDecoder().decode(Welcome.self, from: data)
                    let name = attributes.data
                    //Update the list property in the main thread
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
