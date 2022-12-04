//
//  PostCell.swift
//  ios_instaClone
//
//  Created by Mirzabek on 06/11/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct FeedPostCell: View {
    @State private var showingAlert = false
    var uid: String
    var viewModel: FeedViewModel
    @State var post: Post
    @State var isSharePresent = false
    @State var isPresented = false
    
    
    
    
    var body: some View {
            VStack(spacing: 0){
                HStack(spacing: 0){
                    VStack{
                        if !post.imgUser!.isEmpty {
                            WebImage(url: URL(string: post.imgUser!))
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
                    }.clipShape(Circle())
                        .overlay(RoundedRectangle(cornerRadius: 25).stroke(Utils.color2, lineWidth :2))
                    
                    VStack(alignment: .leading,spacing: 3){
                        Button(action: {
                           // self.isPresented = true
                        }, label: {
                            Text(post.displayname!)
                                .foregroundColor(.black)
                                .font(.system(size: 17))
                                .fontWeight(.medium)

                        })
                        Text(post.time!)
                            .foregroundColor(.gray)
                            .font(.system(size: 15))
                    }.padding(.leading,15)
                    Spacer()
                    
                    Button(action: {
                        self.showingAlert = true
                    }, label: {
                        if uid == post.uid {
                            Image(systemName: "ellipsis")
                                .foregroundColor(.black)
                        }
                    })
                    .buttonStyle(PlainButtonStyle())
                    .alert(isPresented: $showingAlert) {
                        let title = "Delete"
                        let message = "Do you want to delete this post?"
                        return Alert(title: Text(title), message: Text(message), primaryButton: .destructive(Text("Confirm"), action: {
                            // Some action
                            viewModel.apiRemovePost(uid: uid, post: post)
                        }), secondaryButton: .cancel())
                    }
                }.padding(.leading,15)
                    .padding(.trailing,15)
                    .padding(.top,15)
                
                WebImage(url: URL(string: post.imgPost!)).resizable()
                    .scaledToFit().padding(.top,15)
                
                HStack(spacing:0){
                    
                    Button(action: {
                        if post.isLiked!{
                            post.isLiked = false
                        }else{
                            post.isLiked = true
                        }
                        viewModel.apiLikePost(uid: uid, post: post)
                    }, label: {
                        if post.isLiked!{
                            Image(systemName: "heart.fill")
                                .resizable()
                                .frame(width:25).frame(height:25)
                                .foregroundColor(.red)
                        }else{
                            Image(systemName: "heart")
                                .resizable()
                                .frame(width:25).frame(height:25)
                        }
                        
                    })
                    .foregroundColor(.black)
                    .padding(.trailing,15)
                    
                    Button(action: {
                        /* items.removeAll()
                         items.append(viewModel.items)
                         sheet.toggle()
                         */
                        self.isSharePresent = true
                    }, label: {
                        Image(systemName: "arrowshape.turn.up.right")
                            .resizable()
                            .frame(width:25).frame(height:25)
                    }).foregroundColor(.black)
                    .sheet(isPresented: $isSharePresent,onDismiss: {
                        print("Dismiss")
                    }, content: {
                        ActivityViewController(activityItems: [URL(string: "https://www.apple.com")!,URL(string: "https://www.instagram.com")])
                    })
                    
                    
                    .padding(.leading,15)
                    Spacer()
                }
                .padding(.leading,15)
                .padding(.trailing,15)
                .padding(.top,15)
                
                HStack(spacing: 0){
                    Text(post.caption!)
                        .foregroundColor(.black)
                        .font(.system(size: 16))
                    Spacer()
                }.padding(.all,15)
                
            }
        
        
        }
    
}

struct FeedPostCell_Previews: PreviewProvider {
    static var previews: some View {
        FeedPostCell(uid:"uid",viewModel: FeedViewModel(), post: Post(caption: "symvolic", imgPost: Utils.image2))
    }
}



