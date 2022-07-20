//
//  MangaInfo.swift
//  Manga Profile
//
//  Created by Khoa Tran Dang on 20/07/2022.
//

import Foundation

struct MangaInfo: Codable {
    let startDate: String
    let ageRating: String
    let status: Bool
    let coverImage: String
}

struct MangaAttribute: Codable {
    let id: Int
    let canonicalTitle: String
    let synopsis: String
    let averageRating: String
    let posterImage: String
    let status: Bool
}


extension URLSession {
  func fetchData(at url: URL, completion: @escaping (Result<[MangaInfo], Error>) -> Void) {
    self.dataTask(with: url) { (data, response, error) in
      if let error = error {
        completion(.failure(error))
      }

      if let data = data {
        do {
          let manga = try JSONDecoder().decode([MangaInfo].self, from: data)
          completion(.success(manga))
        } catch let decoderError {
          completion(.failure(decoderError))
        }
      }
    }.resume()
  }
}
