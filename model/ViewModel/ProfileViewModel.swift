import Foundation
import SwiftUI
import FirebaseFirestore
class ProfileViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var items: [Post] = []
    @Published var following: [User] = []
    @Published var followers: [User] = []
    
    @Published var email = ""
    @Published var displayname = ""
    @Published var imgUser = ""
    
    func apiPostList(uid: String) {
           isLoading = true
           items.removeAll()
           
           DataBaseStore().loadPosts(uid: uid, completion: {posts in
               self.items = posts!
               self.isLoading = false
           })
       }
    
    func apiSignOut(){
        SessionStore().signOut()
    }
    
    func apiLoadUser(uid: String){
        DataBaseStore().loadUser(uid: uid, completion: { [self] user in
            
          
            self.email = (user?.email)!
            self.displayname = (user?.displayname)!
            self.imgUser = (user?.imgUser)!
            print(self.imgUser)
            
             self.isLoading = false
        })
    }
    
    func apiUploadMyImage(uid: String, image: UIImage){
        isLoading = true
        StorageStore().uploadUserImage(uid: uid, image, completion: { downloadUrl in
            self.apiUpdateMyImage(uid: uid, imgUser: downloadUrl)
            self.apiLoadUser(uid: uid)
        })
    }
    
    func apiUpdateMyImage(uid: String, imgUser: String?){
        DataBaseStore().updateMyImage(uid: uid, imgUser: imgUser)
    }
    func apiLoadFollowing(uid: String) {
         isLoading = true
         following.removeAll()
         
         DataBaseStore().loadFollowing(uid: uid, completion: {users in
             self.following = users!
             self.isLoading = false
         })
     }
     
     func apiLoadFollowers(uid: String) {
         isLoading = true
         followers.removeAll()
         
         DataBaseStore().loadFollowers(uid: uid, completion: {users in
             self.followers = users!
             self.isLoading = false
         })
     }
    func apiRemovePost(uid: String, post: Post) {
          DataBaseStore().removeMyPost(uid: uid, post: post)
          apiPostList(uid: uid)
      }
    
    
}

