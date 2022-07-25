//
//  Manga_ProfileApp.swift
//  Manga Profile
//
//  Created by Khoa Tran Dang on 20/07/2022.
//

import SwiftUI

@main
struct Manga_ProfileApp: App {
    @StateObject var favorites = Favorites()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(favorites)
        }
    }
}
