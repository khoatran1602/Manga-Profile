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
import CoreLocation

struct MangaDetailView: View {
    
    //Declare variables
    //Static Coordinate
    var locationCoordinate = CLLocationCoordinate2D(latitude: 35.652832, longitude: 139.839478)
    //Receiving parameters from MangaListVIew
    @State var mangaList = [Datum]()
    @State var mangaId: String
    @State var imageURL: String
    @State var mangaName: String
    @State var mangaJapanName: String
    @State var mangaDetail: String
    @State var manageRating: String
    //Favorite will scan this view and get this data if something changes
    @EnvironmentObject var favorites: Favorites
    
    var body: some View {
        
        ScrollView {
            VStack {
                //Show map with specific coordinate
                MapView(coordinate: locationCoordinate)
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 250)
                
                //Load Image
                AsyncImage(url: URL(string: imageURL))
                    .clipShape(Circle())
                    .overlay(Circle()
                        .stroke(Color(.white),lineWidth: 4)
                    )
                    .shadow(radius: 7)
                    .offset(y: -130)
                    .padding(.bottom, -130)
                VStack(alignment: .leading) {
                    Text(mangaName)
                        .font(.title)
                    
                    HStack {
                        Text(mangaJapanName)
                        Spacer()
                        Text(manageRating)
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    //A straight line
                    Divider()
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Text("About \(mangaJapanName)")
                        .font(.title2)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Text(mangaDetail)
                    //Add Favorite Button Or Remove
                    Button(favorites.contains(mangaId) ? "Remove From Favorite" : "Add To Favorite") {
                        if favorites.contains(mangaId) {
                            favorites.remove(mangaId)
                        } else {
                            favorites.add(mangaId)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
                .padding()
            }
            .navigationTitle("Manga Information")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MangaDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MangaDetailView(mangaId: "01",
                        imageURL: "LaunchScreen_1",
                        mangaName: "Naruto Shippuden",
                        mangaJapanName: "ナルト",
                        mangaDetail: "About a child...",
                        manageRating: "10.0")
        //Connect MangaDetailView with Favorite
        .environmentObject(Favorites())
    }
}
