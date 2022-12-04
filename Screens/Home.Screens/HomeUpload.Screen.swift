//
//  HomeUpload.Screen.swift
//  ios_instaClone
//
//  Created by Mirzabek on 04/11/22.
//

import SwiftUI

struct HomeUpload_Screen: View {
    @EnvironmentObject var session: SessionStore
    @ObservedObject var viewModel = UploadViewModel()
    @Binding var tabSelection: Int
    @State var caption = ""
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
  
    //function
    func uploadPost(){
        if caption.isEmpty || selectedImage == nil{
            return
        }
        // Send post to server
        let uid = (session.session?.uid)!
        viewModel.apiUploadPost(uid: uid, caption: caption, image: selectedImage!){result in
            if result {
                self.selectedImage = nil
                self.caption = ""
                self.tabSelection = 0
            }
        }
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    ZStack{
                        if selectedImage != nil{
                            Image(uiImage: selectedImage!)
                                .resizable().frame(minWidth: UIScreen.width,maxHeight: UIScreen.width)
                            VStack{
                                HStack{
                                    Spacer()
                                    Button(action: {
                                        selectedImage = nil
                                    }, label: {
                                        Image(systemName: "x.circle").frame(width: 30).frame(height: 30).foregroundColor(.white)
                                    }).padding()
                                }
                                Spacer()
                            }
                        }else{
                            Button(action: {
                                self.sourceType = .photoLibrary
                                self.isImagePickerDisplay.toggle()
                            }, label: {
                                Image(systemName: "camera").frame(width:40).frame(height: 40)
                 
                            }).sheet(isPresented: self.$isImagePickerDisplay){
                                ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
                            }
                        }
                        
                    }.frame(maxWidth: UIScreen.width,maxHeight: UIScreen.width).background(.gray.opacity(0.2))
                    
                    VStack{
                        TextField("Caption",text: $caption).font(Font.system(size: 17,design: .default)).frame(height: 45)
                        Divider()
                    }.padding(.top,10).padding(.leading,20).padding(.trailing,20)
                    
                    Spacer()
                }.padding(.top,40)
                
                if viewModel.isLoading{
                    ProgressView()
                }
            }
            .navigationBarItems(trailing:
                                    Button(action: {
               
                self.uploadPost()
            }, label: {
                Image(systemName:"square.and.arrow.up").font(.system(size: 15))
            })
            ).navigationBarTitle("Upload",displayMode: .inline)
        }
    }
}

struct HomeUpload_Screen_Previews: PreviewProvider {
    static var previews: some View {
        HomeUpload_Screen(tabSelection:.constant(0))
    }
}
