//
//  HomeProfile.Screen.swift
//  ios_instaClone
//
//  Created by Mirzabek on 04/11/22.
//

import SwiftUI
import SDWebImageSwiftUI
struct HomeProfile_Screen: View {
    
    @EnvironmentObject var session: SessionStore
    @ObservedObject var viewModel = ProfileViewModel()
    @State var level = 1
    @State var isActionSheet = false
    @State private var isImagePickerDisplay = false
    @State private var selectedImage: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var showAlert = false
    
    //functions
    func postSize() -> CGFloat{
          if  level == 1{
              return UIScreen.width / CGFloat(Int(level)) - 20
            }
            return UIScreen.width/CGFloat(level) - 15
        }
    
    func listStyle(type: Int){
         level = type
     }
    
    
        func columns() -> [GridItem]{
                return Array(repeating: GridItem(.flexible(minimum: postSize()), spacing: 10), count: self.level)
        }
    
    func uploadImage(){
        let uid = (session.session?.uid)!
        viewModel.apiUploadMyImage(uid:uid, image: selectedImage!)
    }
    

   
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack(spacing: 0){
                    ZStack{
                        //profile Image
                        VStack{
                if !viewModel.imgUser.isEmpty {
            WebImage(url: URL(string:viewModel.imgUser)).resizable()
                    
     .clipShape(Circle())
     .scaledToFill()
     .frame(height:70)
     .frame(width:70)
     .padding(.all, 2)
                    
     }else{
  Image("ic_person")
             .resizable()
             .clipShape(Circle())
             .frame(height:70)
             .frame(width:70)
             .padding(.all, 2)
                                                            
                                                               
                    }
                        }
     .overlay(RoundedRectangle(cornerRadius: 37)
       .stroke(Utils.color2, lineWidth: 2))
                        HStack{
                            Spacer()
                            VStack{
                                Spacer()
                                Button(action: {
                                    self.isActionSheet = true
                                }, label: {
                                    Image(systemName: "plus.circle.fill")
                                        .resizable().frame(width: 20,height: 20)
                     
                                }).actionSheet(isPresented: $isActionSheet) {
                                    ActionSheet(
                                        title: Text("Actions"),
                                        buttons: [
                                            .cancel { print(self.isActionSheet) },
                                            .default(Text("Pick Photo")){
                                                self.sourceType = .photoLibrary
                                                self.isImagePickerDisplay.toggle()
                                            },
                                            .default(Text("Take Photo")){
                                                self.sourceType = .camera
                                                self.isImagePickerDisplay.toggle()
                                            },
                                        ]
                                    )
                                    
                                }
                                
                                .sheet(isPresented: self.$isImagePickerDisplay,onDismiss: uploadImage){
                                    ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
                                }
                           
                            }
                        }.frame(width: 75,height: 75)
                    }
                   
                        Text(viewModel.displayname).foregroundColor(.black)
                            .font(.system(size: 17))
                            .fontWeight(.medium)
                            .padding(.top,15)
                    
                
                        Text(viewModel.email).foregroundColor(.gray)
                            .font(.system(size: 15))
                            .fontWeight(.medium)
                            .padding(.top,3)
                    
                    //post following counts
                    
                    HStack{
                        VStack{
                            Text(String(viewModel.items.count))
                                .foregroundColor(.black)
                                .font(.system(size: 17))
                                .fontWeight(.medium)
                            
                            Text("Posts")
                                .foregroundColor(.gray)
                                .font(.system(size: 15))
                        }.frame(maxWidth: UIScreen.width/3,maxHeight: 60)
                        VStack{}.frame(width: 1,height: 25).background(.black.opacity(0.5))
                        VStack{
                            Text(String(viewModel.followers.count))
                                .foregroundColor(.black)
                                .font(.system(size: 17))
                                .fontWeight(.medium)
                            
                            Text("Followers")
                                .foregroundColor(.gray)
                                .font(.system(size: 15))
                        }.frame(maxWidth: UIScreen.width/3,maxHeight: 60)
                        VStack{}.frame(width: 1,height: 25).background(.black.opacity(0.5))
                        
                        VStack{
                            Text(String(viewModel.following.count))
                                .foregroundColor(.black)
                                .font(.system(size: 17))
                                .fontWeight(.medium)
                            
                            Text("Following")
                                .foregroundColor(.gray)
                                .font(.system(size: 15))
                        }.frame(maxWidth: UIScreen.width/3,maxHeight: 60)
                    }.padding(.top,10)
                    
                    // button
                    HStack(spacing: 0){
                                            VStack{
                                                Button(action: {
                                                    listStyle(type: 1)
                                                }, label: {
                                                    Image(systemName: "rectangle.grid.1x2")
                                                        .resizable()
                                                        .frame(width: 22, height: 22)
                                                })
                                            }.frame(maxWidth: UIScreen.width/2, maxHeight: 36)
                                            VStack{
                                                Button(action: {
                                                    listStyle(type: 2)
                                                }, label: {
                                                    Image(systemName: "rectangle.grid.2x2")
                                                        .resizable()
                                                        .frame(width: 22, height: 22)
                                                })
                                            }.frame(maxWidth: UIScreen.width/2, maxHeight: 36)
                                        }
                                    

                    //my posts
                    ScrollView{
                        LazyVGrid(columns: columns(), spacing: 10){
                            ForEach(viewModel.items, id:\.self){ item in
                                if let uid = session.session?.uid! {
                                    MyPostCell(uid:uid,viewModel: viewModel,post: item, length: postSize())
                                }
                                if level == 1 {
                                    Divider()
                                }
                            }
                        }
                    }.padding(.top, 10).listStyle(PlainListStyle())
                    
                    if viewModel.isLoading{
                        ProgressView()
                    }
                    
                }
                .navigationBarItems(trailing:
                                        Button(action: {
                    self.showAlert = true
                }, label: {
                    Image(systemName: "pip.exit").font(.system(size: 20))
                    // alert
                }).alert(isPresented: $showAlert) {
                    let title = "Signout"
                    let message = "Do you want to signout?"
                    return Alert(title: Text(title), message: Text(message), primaryButton: .destructive(Text("Confirm"), action: {
                        viewModel.apiSignOut()
                    }), secondaryButton: .cancel())
                }
                )
                .navigationBarTitle("Profile",displayMode:.inline)
            }.onAppear{
                let uid = (session.session?.uid)!
                viewModel.apiLoadUser(uid:uid)
                viewModel.apiPostList(uid: uid)
                viewModel.apiLoadFollowing(uid: uid)
                viewModel.apiLoadFollowers(uid: uid)
            }
        }
    }
}
struct HomeProfile_Screen_Previews: PreviewProvider {
    static var previews: some View {
        HomeProfile_Screen()
    }
}

 
