//
//  Home.swift
//  ios_instaClone
//
//  Created by Mirzabek on 04/11/22.
//

import SwiftUI

struct Home: View {
    @State private var tabSelection = 0
    var body: some View {
        
        TabView(selection: $tabSelection){
            
            HomeFeed_Screen(tabSelection: $tabSelection).font(.system(size: 30,weight: .bold,design: .rounded))
                .tabItem{
                    Image(systemName: "house")
                }.tag(0)
            
            HomeSearch_Screen().font(.system(size: 30,weight: .bold,design: .rounded))
                .tabItem{
                    Image(systemName: "magnifyingglass")
                }.tag(1)
            
            HomeUpload_Screen(tabSelection: $tabSelection).font(.system(size: 30,weight: .bold,design: .rounded))
                .tabItem{
                    Image(systemName: "camera")
                }.tag(2)
            
            HomeLikesScreen().font(.system(size: 30,weight: .bold,design: .rounded))
                .tabItem{
                    Image(systemName: "heart")
                }.tag(3)
            
            HomeProfile_Screen().font(.system(size: 30,weight: .bold,design: .rounded))
                .tabItem{
                    Image(systemName: "person")
                }.tag(4)
        }.accentColor(.black)
            .onAppear{
                UITabBar.appearance().barTintColor = .white
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
