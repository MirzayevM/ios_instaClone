//
//  UploadViewModel.swift
//  ios_instaClone
//
//  Created by Mirzabek on 23/11/22.
//

import Foundation
import SwiftUI

class UploadViewModel: ObservableObject{
    @Published var isLoading = false
    
    func apiUploadPostImage(uid:String,image: UIImage, completion: @escaping(String) -> ()){
        StorageStore().uploadPostImage(uid: uid, image, completion: { donwloadUrl in
            print(donwloadUrl)
            completion(donwloadUrl)
            
        })
    }
    
    func apiUploadPost(uid:String, caption: String, image: UIImage, completion: @escaping (Bool) -> ()){
        isLoading = true
        
        apiLoadUser(uid: uid){ user in
            self.apiUploadPostImage(uid: uid, image: image, completion: { downloadUrl in
                var post = Post(caption:caption, imgPost: downloadUrl)
                post.displayname = user?.displayname
                post.imgUser = user?.imgUser
                post.uid = user?.uid
                
                DataBaseStore().storePost(post:post){ result in
                    self.isLoading = false
                    completion(result)
                    
                }
            })
        }
    }
    
    func apiLoadUser(uid: String, completion: @escaping (User?) -> ()){
         DataBaseStore().loadUser(uid: uid, completion: { user in
             completion(user)
         })
     }
}
