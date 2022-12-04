//
//  SearchViewModekl.swift
//  ios_instaClone
//
//  Created by Mirzabek on 08/11/22.
//

import Foundation
import SwiftUI

class SearchViewModel:ObservableObject{
    
    @Published var isLoading = false
    @Published var items: [User] = []
    
    func apiUserList(uid: String, keyword: String){
        isLoading = true
        items.removeAll()
        
        DataBaseStore().loadUsers(keyword: keyword){ users in
        DataBaseStore().loadFollowing(uid: uid){ following in
        self.items = self.mergeUsers(uid: uid, users: users!, following: following!)
        self.isLoading = false
                }
            }
        }
        
        func mergeUsers(uid: String, users: [User], following: [User]) -> [User]{
            var items: [User] = []
            
            for u in users {
                var user = u
                for f in following {
                    if u.uid == f.uid {
                        user.isFollowed = true
                        break
                    }
                }
                if uid != user.uid {
                    items.append(user)
                }
            }
            return items
        }
        
        
        func apiFollowUser(uid: String, to: User){
            DataBaseStore().loadUser(uid:uid){ me in
                DataBaseStore().followUser(me: me!, to: to){isFollowed in
                    self.apiUserList(uid: uid, keyword: "")
                }
            }
        }
        
        func apiUnFollowUser(uid: String, to: User){
            DataBaseStore().loadUser(uid:uid){ me in
                DataBaseStore().unFollowUser(me: me!, to: to){isFollowed in
                    self.apiUserList(uid: uid, keyword: "")
                }
            }
        }
        
    }

