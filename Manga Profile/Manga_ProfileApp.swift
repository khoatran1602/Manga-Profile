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
