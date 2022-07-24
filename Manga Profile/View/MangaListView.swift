//
//  MangaListView.swift
//  Manga Profile
//
//  Created by Khoa Tran Dang on 20/07/2022.
//

import SwiftUI

struct MangaListView: View {
    @State var mangaList = [Datum]()
    @State private var showFavoritesOnly = false
    @StateObject var favorites = Favorites()

    var filteredManga: [Datum] {
        mangaList.filter { item in
            (!showFavoritesOnly || item.isFavorite ?? false)
        }
    }
    
    
    var body: some View {
        VStack {
            Toggle(isOn: $showFavoritesOnly) {
                Text("Favorites only")
            }
            List(mangaList, id: \.id) { item in
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
                                            MangaDetailView(imageURL: item.attributes.posterImage.tiny,
                                                            mangaName: item.attributes.canonicalTitle,
                                                            mangaJapanName: item.attributes.titles.enJp,
                                                            mangaDetail: item.attributes.synopsis,
                                                            manageRating: item.attributes.averageRating ?? "No Rated Yet")) {
                                Text(item.attributes.canonicalTitle)
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .padding(.top)
                            }
                            
                            Spacer()
                            
                            if favorites.contains(mangaList) {
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
            .onAppear() {
                apiCall().getMangaList { (mangaList) in
                    self.mangaList = mangaList
                }
            }.navigationTitle("Manga List")
        }
        .environmentObject(favorites)
    }
}

struct MangaListView_Previews: PreviewProvider {
    static var previews: some View {
        MangaListView()
    }
}
