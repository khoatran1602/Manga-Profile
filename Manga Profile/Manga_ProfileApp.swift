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
    //Initialize a Favorite object for a given property only once during the life time of the app
    @StateObject var favorites = Favorites()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            //Connect Manga_ProfileApp with Favorite. This has to be add here first. If not, favorite will give errors ("No ancestor")
                .environmentObject(favorites)
        }
    }
}
