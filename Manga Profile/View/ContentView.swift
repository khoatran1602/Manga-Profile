/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Your name (e.g. Nguyen Van Minh)
  ID: Your student id (e.g. 1234567)
  Created  date: dd/mm/yyyy (e.g. 31/07/2022)
  Last modified: dd/mm/yyyy (e.g. 05/08/2022)
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct ContentView: View {
    
    let roundRect = RoundedRectangle(cornerRadius: 25.0)
    
    var body: some View {
        NavigationView {
            Color.blue
                .ignoresSafeArea()
                .overlay (
                    TabView {
                        FirstView()
                        SecondView()
                        ThirdView()
                    })
                .tabViewStyle(.page)
                .background(.blue)
                .edgesIgnoringSafeArea(.vertical)
        }
    }
}

struct FirstView: View {
    var body: some View {
        VStack {
            Image("LaunchScreen_1")
                .resizable()
                .padding()
                .scaledToFit()
                .frame(width: 200, height: 200, alignment: .center)
            Spacer()
                .frame(height: 50)
            Text("Welcome to Manga Profile!")
                .font(.custom("Marker Felt", size: 18))
                .fontWeight(.semibold)
                .foregroundColor(Color.red)
                .padding()
                .multilineTextAlignment(.center)
        }
    }
}

struct SecondView: View {
    var body: some View {
        VStack {
            Image("LaunchScreen_2")
                .resizable()
                .padding()
                .scaledToFill()
                .frame(width: 200, height: 200, alignment: .center)
            Spacer()
                .frame(height: 50)
            Text("Where you can find your favorire manga and its information")
                .font(.custom("Marker Felt", size: 18))
                .fontWeight(.semibold)
                .foregroundColor(Color.red)
                .padding()
                .multilineTextAlignment(.center)
        }
    }
}

struct ThirdView: View {
    var body: some View {
        VStack {
            Image("LaunchScreen_3")
                .resizable()
                .padding()
                .scaledToFill()
                .frame(width: 200, height: 200, alignment: .center)
            Spacer()
                .frame(height: 50)
            Text("We hope that you can use our application to find what you are looking for")
                .font(.custom("Marker Felt", size: 18))
                .fontWeight(.semibold)
                .foregroundColor(Color.red)
                .padding()
                .multilineTextAlignment(.center)
            NavigationLink(destination: MangaListView()) {
                Text("Let's explore!")
                    .foregroundColor(.white)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}
