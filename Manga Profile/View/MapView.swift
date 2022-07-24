//
//  MapView.swift
//  Manga Profile
//
//  Created by Khoa Tran Dang on 23/07/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    var coordinate: CLLocationCoordinate2D
    
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 35.652832, longitude: 139.839478),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )

    var body: some View {
        Map(coordinateRegion: $region)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: CLLocationCoordinate2D(latitude: 36.2048, longitude: 138.2529))
    }
}
