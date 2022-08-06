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

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            
            TabView {
                FirstView()
                SecondView()
                ThirdView()
            }
            .tabViewStyle(.page)
            .background(.black)
            .edgesIgnoringSafeArea(.vertical)
        }
        .preferredColorScheme(.dark)
    }
}

struct FirstView: View {
    
    var body: some View {
        VStack {
            Text("Welcome to Manga Profile!")
                .font(.title)
                .italic()
                .fontWeight(.semibold)
                .foregroundColor(randomColor())
                .multilineTextAlignment(.center)
            Spacer()
                .frame(height: 50)
            Text("Where you can find your favorire manga and its information")
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(randomColor())
                .multilineTextAlignment(.center)
            //Displaying welcome gif
            GifImageView("welcome")
            GifImageView("welcome_1")
            GifImageView("welcome_2")
            //Make little gap among gifs
            Spacer()
                .frame(height: 50)
        }
    }
}

struct SecondView: View {
    var body: some View {
        VStack {
            Image("LaunchScreen_2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.screenSize.width * 3,
                       height: UIScreen.screenSize.height / 2)
                .scaledToFill()
        }
    }
}

struct ThirdView: View {
    
    var body: some View {
        VStack {
            Text("Some of the features:\n" +
                 "- Mark Favorite\n" +
                 "- Read Manga's Detail Information\n" +
                 "- Show Favorite Only")
            .font(.custom("Marker Felt", size: 20))
            .fontWeight(.semibold)
            .hoverEffect(.lift)
            .foregroundColor(randomColor())
            .multilineTextAlignment(.center)
            Spacer()
                .frame(height: 20)
            GifImageView("welcome_3")
            GifImageView("welcome_4")
            Spacer()
                .frame(height: 30)
            Text("We hope that you can use our application to find what you are looking for")
                .font(.custom("OpenSans-Bold", size: 18))
                .fontWeight(.semibold)
                .foregroundColor(randomColor())
                .padding()
                .multilineTextAlignment(.center)
            NavigationLink(destination: MangaListView()) {
                Text("Let's explore!")
                    .italic()
                    .fontWeight(.bold)
                    .foregroundColor(randomColor())
            }
            Spacer()
                .frame(height: 50)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension UIScreen{
    static let screenSize = UIScreen.main.bounds
}

