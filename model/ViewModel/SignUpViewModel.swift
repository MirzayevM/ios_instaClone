//
//  SignUpViewModel.swift
//  ios_instaClone
//
//  Created by Mirzabek on 10/11/22.
//


import Foundation

class SignUpViewModel: ObservableObject {
    
    @Published var isLoading = false
    
    func apiSignUp(email: String, password: String, completion: @escaping (Bool) -> ()){
        isLoading = true
        SessionStore().signUp(email: email, password: password, completion: {(res,err) in
            self.isLoading = false
            if err != nil {
                print("Check email or password")
                completion(false)
            }else{
                print("User signed up")
                completion(true)
            }
        })
    }
    
    func apiUserStore(user:User){
        DataBaseStore().storeUser(user: user)
    }
    
}
