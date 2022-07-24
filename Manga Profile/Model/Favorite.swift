//
//  Favorite.swift
//  Manga Profile
//
//  Created by Khoa Tran Dang on 24/07/2022.
//

import Foundation

class Favorites: ObservableObject {
    var mangaList = [Datum]()

    // the actual resorts the user has favorited
    private var mangaFavoriteList: Set<String>

    // the key we're using to read/write in UserDefaults
    private let saveKey = "Favorites"

    init() {
        // load our saved data

        // still here? Use an empty array
        mangaFavoriteList = []
    }

    // returns true if our set contains this resort
    func contains(_ list: [Datum]) -> Bool {
        for item in list {
            if (mangaFavoriteList.contains(item.id)) {
                return true
            }
        }
        return false
    }

    // adds the resort to our set, updates all views, and saves the change
    func add(_ list: [Datum]) {
        objectWillChange.send()
        for item in list {
            mangaFavoriteList.insert(item.id)
        }
        save()
    }

    // removes the resort from our set, updates all views, and saves the change
    func remove(_ list: [Datum]) {
        objectWillChange.send()
        for item in list {
            mangaFavoriteList.remove(item.id)
        }
        save()
    }

    func save() {
        // write out our data
    }
}
