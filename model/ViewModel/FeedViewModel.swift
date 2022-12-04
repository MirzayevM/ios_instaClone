//
//  FeedViewModel.swift
//  ios_instaClone
//
//  Created by Mirzabek on 06/11/22.
//

import Foundation

class FeedViewModel:ObservableObject{
    @Published var isLoading = false
    @Published var items : [Post] = []
    
    func apiFeedList(uid: String) {
        isLoading = true
        items.removeAll()
        
        DataBaseStore().loadFeeds(uid: uid, completion: {posts in
            self.items = posts!
            self.isLoading = false
        })
    }
    
    func apiLikePost(uid: String, post: Post) {
           DataBaseStore().likeFeedPost(uid: uid, post: post)
        
       }
    func apiRemovePost(uid: String, post: Post) {
          DataBaseStore().removeMyPost(uid: uid, post: post)
          apiFeedList(uid: uid)
      }
    
}
