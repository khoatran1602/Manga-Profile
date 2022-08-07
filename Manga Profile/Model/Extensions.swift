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
