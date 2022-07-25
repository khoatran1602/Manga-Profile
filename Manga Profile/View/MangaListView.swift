//
//  MangaListView.swift
//  Manga Profile
//
//  Created by Khoa Tran Dang on 20/07/2022.
//

import SwiftUI

struct MangaListView: View {
    @State var originalList = [Datum]()
    @State var mangaList = [Datum]()
    @State private var showFavoritesOnly = false
    //@StateObject var favorites = Favorites()
    @State var isFavorite: Bool = false
    @EnvironmentObject var favorites: Favorites
    @State var mangaFavoriteList = [Datum]()
    @State var reservedList = [Datum]()
    @State var num = 0
    
//    func getList() -> [Datum] {
//        if (showFavoritesOnly) {
//            for item in mangaList {
//                if (favorites.contains(item.id) && !mangaFavoriteList.contains(where: {$0.id == item.id})) {
//                    mangaFavoriteList.append(item)
//                }
//            }
//            return mangaFavoriteList
//        } else {
//            for item in originalList {
//                reservedList.append(item)
//            }
//            return reservedList
//        }
//    }
    
    var body: some View {
        VStack {
            List {
//                Toggle(isOn: $showFavoritesOnly) {
//                    Text("Favorites only")
//                }
                ForEach(mangaList, id: \.id) { item in
                    ScrollView {
                        VStack(alignment: .leading) {
                            HStack {
                                AsyncImage(url: URL(string: item.attributes.posterImage.tiny)) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.red
                                }
                                .frame(width: 128, height: 128)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                                .padding(.top)
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
                                }
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
            }
            .onAppear() {
                apiCall().getMangaList { (mangaList) in
                    self.mangaList = mangaList
                }
            }
//            .refreshable {
//                if (showFavoritesOnly) {
//                    mangaList = getList()
//                } else {
//                    mangaList = getList()
//                }
//            }
            .navigationTitle("Manga List")
        }
        .environmentObject(favorites)
    }
}

struct MangaListView_Previews: PreviewProvider {
    static var previews: some View {
        MangaListView()
    }
}
