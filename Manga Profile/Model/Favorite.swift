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
