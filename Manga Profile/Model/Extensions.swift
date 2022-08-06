//
//  Extensions.swift
//  Manga Profile
//
//  Created by Khoa Tran Dang on 06/08/2022.
//

import Foundation
import SwiftUI

//Generate random colors
func randomColor() -> Color {
    let color = UIColor(red: 1,
                        green: .random(in: 0...1),
                        blue: .random(in: 0...1),
                        alpha: 1
    )
    return Color(color)
    
}
