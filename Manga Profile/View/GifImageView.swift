//
//  GifImageView.swift
//  Manga Profile
//
//  Created by Khoa Tran Dang on 06/08/2022.
//

import SwiftUI
import WebKit

struct GifImageView: UIViewRepresentable {
    private let name: String
    
    init(_ name: String) {
        self.name = name
    }
    
    func makeUIView(context: Context) -> some UIView {
        let webView = WKWebView()
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!
        let data = try! Data(contentsOf: url)
        
        webView.load(data,
                     mimeType: "image/gif",
                     characterEncodingName: "UTF-8",
                     baseURL: url.deletingLastPathComponent()
        )
        
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.reloadInputViews()
    }
}

struct GifImageView_Previews: PreviewProvider {
    static var previews: some View {
        GifImageView("welcome")
    }
}
