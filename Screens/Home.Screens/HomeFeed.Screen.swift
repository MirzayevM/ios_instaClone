//
//  HomeFeed.Screen.swift
//  ios_instaClone
//
//  Created by Mirzabek on 04/11/22.
//

import SwiftUI

struct HomeFeed_Screen: View {
    
    @Binding var tabSelection : Int
    @EnvironmentObject var session: SessionStore
    @ObservedObject var viewModel = FeedViewModel()
   
    var body: some View {
        
        NavigationView{
            ZStack{
                ScrollView(showsIndicators: false){
                    
                        ForEach(viewModel.items,id:\.self){ item in
                            if let uid = session.session?.uid! {
                                FeedPostCell(uid:uid, viewModel: viewModel, post: item)
                                  
                            }
                        }
                }
               
                
                if viewModel.isLoading{
                    ProgressView()
                }
                
            }
            .navigationBarItems(trailing:
                                    Button(action: {
                self.tabSelection = 2
            }, label: {
             

                Image(systemName:"camera").font(.system(size: 15))
            })
            ).navigationBarTitle("Instagram",displayMode: .inline)
            
        }.onAppear{
            if let uid = session.session?.uid! {
                viewModel.apiFeedList(uid: uid)
                        }
        }
    }
}

struct HomeFeed_Screen_Previews: PreviewProvider {
    static var previews: some View {
        HomeFeed_Screen(tabSelection: .constant(0))
    }
}
