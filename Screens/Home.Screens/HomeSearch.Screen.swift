//
//  HomeSearch.Screen.swift
//  ios_instaClone
//
//  Created by Mirzabek on 04/11/22.
//

import SwiftUI

struct HomeSearch_Screen: View {
  
    @EnvironmentObject var session: SessionStore
    @ObservedObject var viewModel = SearchViewModel()
    @State var keyword = ""
    
    var body: some View {
        NavigationView{
           ZStack{
                VStack{
              //text Field
                    TextField("Search for User",text: $keyword).padding(.leading,15).padding(.trailing,15)
                        .frame(height: 45).font(.system(size: 16))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(.black.opacity(0.5),lineWidth: 0.5)).padding(.leading,20).padding(.trailing,20).padding(.top,20)
                    
                    
                    List{
                        ForEach(viewModel.items,id: \.self){ item in
                            let uid = (session.session?.uid) ?? ""
                            UserCell(uid: uid, user: item, viewModel: viewModel)
                            .listRowInsets(EdgeInsets())
                            .buttonStyle(PlainButtonStyle())
                            
                        }
                    }.listStyle(PlainListStyle()).font(.system(size: 20))
                }
                if viewModel.isLoading{
                    ProgressView()
                }
            }.navigationBarTitle("Search",displayMode: .inline)
        }.onAppear{
            let uid = (session.session?.uid) ?? ""
            viewModel.apiUserList(uid: uid, keyword: keyword)
        }
    }
}

struct HomeSearch_Screen_Previews: PreviewProvider {
    static var previews: some View {
        HomeSearch_Screen()
    }
}
