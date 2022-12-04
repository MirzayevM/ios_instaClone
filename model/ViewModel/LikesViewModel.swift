//
//  LikesViewModel.swift
//  ios_instaClone
//
//  Created by Mirzabek on 06/11/22.
//

import Foundation

import Foundation

class LikesViewModel:ObservableObject{
    @Published var isLoading = false
    @Published var items : [Post] = []
    
    func apiLikesList(uid: String) {
        isLoading = true
        items.removeAll()
        
        DataBaseStore().loadLikes(uid: uid, completion: {posts in
            self.items = posts!
            self.isLoading = false
        })
    }
    
   func apiLikePost(uid: String, post: Post) {
          DataBaseStore().likeFeedPost(uid: uid, post: post)
          apiLikesList(uid: uid)
      }
      
      func apiRemovePost(uid: String, post: Post) {
          DataBaseStore().removeMyPost(uid: uid, post: post)
          apiLikesList(uid: uid)
      }
    
}
