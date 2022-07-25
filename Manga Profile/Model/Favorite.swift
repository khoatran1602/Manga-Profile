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
