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

struct MangaListView: View {
    
    //Declare variables
    @State var mangaList = [Datum]()
    @State private var showFavoritesOnly = false
    //@StateObject var favorites = Favorites()
    @State var isFavorite: Bool = false
    @EnvironmentObject var favorites: Favorites
    @State var mangaFavoriteList = [Datum]()
    
    //Get users' favorite manga list and return it
    func getList() -> [Datum] {
        if (showFavoritesOnly) {
            for item in mangaList {
                if (favorites.contains(item.id) && !mangaFavoriteList.contains(where: {$0.id == item.id})) {
                    mangaFavoriteList.append(item)
                }
            }
        }
        return mangaFavoriteList
    }
    
    var body: some View {
        VStack {
            List {
                //Change state of variable showFavoritesOnly
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }
                //Display each Manga on a row
                ForEach(mangaList, id: \.id) { item in
                    VStack(alignment: .leading) {
                        HStack {
                            //Get image from URL and change its shape
                            AsyncImage(url: URL(string: item.attributes.posterImage.tiny)) { image in
                                image.resizable()
                            } placeholder: {
                                Color.red
                            }
                            .frame(width: 128, height: 128)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .padding(.top)
                            //Click the manga's name to go to MangaDetailView
                            NavigationLink(destination:
                                            MangaDetailView(mangaId: item.id,
                                                            imageURL: item.attributes.posterImage.tiny,
                                                            mangaName: item.attributes.canonicalTitle,
                                                            mangaJapanName: item.attributes.titles.enJp,
                                                            mangaDetail: item.attributes.synopsis,
                                                            manageRating: item.attributes.averageRating ?? "No Rated Yet")) {
                                Text(item.attributes.canonicalTitle)
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .padding(.top)
                                    .foregroundColor(.blue)
                            }
                            
                            //Yellow star to mark users' favorite manga
                            if favorites.contains(item.id) {
                                Spacer()
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                            
                        }
                        Spacer()
                            .frame(height: 20)
                    }
                }
            }
            //Call the API
            .onAppear() {
                apiCall().getMangaList { (mangaList) in
                    self.mangaList = mangaList
                }
            }
            //Pull to refresh data to show favorite list or original list
            .refreshable {
                if (showFavoritesOnly) {
                    mangaList = getList()
                } else {
                    apiCall().getMangaList { (mangaList) in
                        self.mangaList = mangaList
                    }
                }
            }
            
            //Name that appears on top of this view
            .navigationTitle("Manga List")
        }
        //
        .environmentObject(favorites)
    }
}

struct MangaListView_Previews: PreviewProvider {
    static var previews: some View {
        MangaListView()
    }
}
