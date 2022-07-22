//
//  MangaListView.swift
//  Manga Profile
//
//  Created by Khoa Tran Dang on 20/07/2022.
//

import SwiftUI

struct MangaListView: View {
    @State var mangaList = [Datum]()
    
    var body: some View {
        List(mangaList, id: \.id) { item in
            VStack(alignment: .leading) {
                Text(item.attributes.canonicalTitle)
                    .font(.title)
                    .fontWeight(.bold)
            }
        }
        .onAppear() {
            apiCall().getMangaList { (mangaList) in
                self.mangaList = mangaList
            }
        }.navigationTitle("Manga List")
    }
}

struct MangaListView_Previews: PreviewProvider {
    static var previews: some View {
        MangaListView()
    }
}
