//
//  StarterScreen.swift
//  ios_instaClone
//
//  Created by Mirzabek on 01/11/22.
//

import SwiftUI

struct StarterScreen: View {
    @EnvironmentObject var session: SessionStore
    var body: some View {
        VStack{
            if session.session != nil{
                Home()
            }else{
                SignIn()
            }
        }.onAppear{
            session.listen()
        }
    }
}

struct StarterScreen_Previews: PreviewProvider {
    static var previews: some View {
        StarterScreen()
    }
}
