//
//  UserCell.swift
//  ios_instaClone
//
//  Created by Mirzabek on 08/11/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserCell: View {
     var uid: String
     var user: User
     var viewModel: SearchViewModel
   
    
    var body: some View {
        HStack(spacing: 0){
      
            VStack{
                if !user.imgUser!.isEmpty {
                    WebImage(url: URL(string: user.imgUser!))
                        .resizable()
                        .frame(width: 50, height: 50)
                        .background(.gray.opacity(0.2))
                        .clipShape(Circle())
                } else {
                    Image("ic_person")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .background(.gray.opacity(0.2))
                        .clipShape(Circle())
                }
            }.overlay(RoundedRectangle(cornerRadius: 30).stroke(Utils.color1, lineWidth: 2))
            
            VStack(alignment: .leading, spacing: 3){
                
                Text(user.displayname!)
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                
                Text(user.email!)
                    .foregroundColor(.black.opacity(0.7))
                    .fontWeight(.medium)
            }.padding(.leading, 15)
            
            Spacer()
            
            Button(action: {
                   if user.isFollowed {
                       viewModel.apiUnFollowUser(uid: uid, to: user)
                   }else{
                       viewModel.apiFollowUser(uid: uid, to: user)
                   }
               }, label: {
                   if user.isFollowed {
                       Text("Following")
                           .font(.system(size: 15))
                           .foregroundColor(.black.opacity(0.5))
                           .frame(width:90, height:30)
                           .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray,lineWidth: 1))
                   }else{
                       Text("Follow")
                           .font(.system(size: 15))
                           .foregroundColor(.black.opacity(0.5))
                           .frame(width:90, height:30)
                           .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray,lineWidth: 1))
                   }
                   
               })
        }.padding(20)
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell(uid: "uid", user: User(uid: "1", email: "Mirzabek", displayname: "mirzabekmirzayev1@gmail.com"),viewModel: SearchViewModel())
    }
}

