//
//  Favorite.swift
//  Manga Profile
//
//  Created by Khoa Tran Dang on 24/07/2022.
//

import Foundation

class Favorites: ObservableObject {
    
    private var mangaFavoriteList: Set<String>
    private var saveKey = "Favorites"

    init() {
        mangaFavoriteList = []
    }

    func contains(_ list: String) -> Bool {
        mangaFavoriteList.contains(list)
    }

    func add(_ list: String) {
        objectWillChange.send()
        mangaFavoriteList.insert(list)
        save()
    }

    func remove(_ list: String) {
        objectWillChange.send()
        mangaFavoriteList.remove(list)
        save()
    }

    func save() {
    }
}
