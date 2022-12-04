//
//  SignUp.swift
//  ios_instaClone
//
//  Created by Mirzabek on 01/11/22.
//

import SwiftUI

struct SignUp: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var session: SessionStore
    
    @State var isEmail = false
    @State var isPassword = false
    @State var isCPassword = false
    @State var fullname = "Mirzabek"
    @State var email = "mirzabekmirzayev122@gmail.com"
    @State var password = "1234567mMn!"
    @State var cpassword = "1234567mMn!"
    @ObservedObject var viewModel = SignUpViewModel()
    
    //function to signUp
    func doSignUp(){
        if email.isValidEmail && password.isValidPassword && password == cpassword {
            viewModel.apiSignUp(email: email, password: password, completion: { result in
                if !result {
                    
                } else{
                    var user = User(email: email, displayname: fullname, imgUser: "")
                    user.uid = session.session?.uid
                    viewModel.apiUserStore(user: user)
                    presentation.wrappedValue.dismiss()
                }
            })
        }
        if email.isValidEmail == false{
            isEmail = true
        } else { isEmail = false}
        if password.isValidPassword == false {
            isPassword = true
        } else { isPassword = false}
        if password != cpassword { isCPassword = true } else { isCPassword = false}
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Utils.color1,Utils.color2]), startPoint: .bottom, endPoint: .top)
                
                VStack(spacing: 10){
                    Spacer()
                    Text("app_name").foregroundColor(.white).font(Font.custom("Billabong", size: 45))
                    //fullname text Field
                    TextField("fullname", text: $fullname)
                        .foregroundColor(Color.white)
                        .padding()
                        .frame(height: 50)
                        .background(Color.white.opacity(0.4))
                        .cornerRadius(10)
                    
                    // Email Text Field
                    VStack(){
                        TextField("email", text: $email)
                            .foregroundColor(Color.white)
                            .padding()
                            .frame(height: 50)
                            .background(Color.white.opacity(0.4))
                            .cornerRadius(10)
                        if isEmail {
                            Text("Error Email")
                                .foregroundColor(.black)
                                .padding(.leading)
                                .font(.system(size: 17))
                        }
                    }
                    // Password Text Field
                    VStack(alignment: .leading){
                        SecureField("password", text: $password)
                            .foregroundColor(Color.white)
                            .padding()
                            .frame(height: 50)
                            .background(Color.white.opacity(0.4))
                            .cornerRadius(10)
                        if isPassword {
                            Text("The password must contain at least 1 capital letter, number and symbol!")
                                .foregroundColor(.black)
                                .font(.system(size: 15))
                        }
                    }
                    
                    // Conform Password Text Field
                    VStack{
                        SecureField("cpassword", text: $cpassword)
                            .foregroundColor(Color.white)
                            .padding()
                            .frame(height: 50)
                            .background(Color.white.opacity(0.4))
                            .cornerRadius(10)
                        
                        if isCPassword {
                            Text("The password is not the same!")
                                .foregroundColor(.black)
                                .font(.system(size: 15))
                        }
                    }
                    
                    // Button signUp
                    Button(action: {
                        doSignUp()
                    }, label: {
                        Text("sign_up").foregroundColor(.white).frame(maxWidth: .infinity).padding().background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1.5)).foregroundColor(.white.opacity(0.4))
                    }).padding(.top,10)
                    Spacer()
                    //bottom buttons
                    VStack{
                       
                        HStack{
                            Text("already_have_account").foregroundColor(.white)
                           Button(action: {
                               presentation.wrappedValue.dismiss()
                           }, label: {
                               Text("sign_in").foregroundColor(.white).fontWeight(.bold)
                           })
                        }
                    }.frame(maxWidth:.infinity).frame(maxHeight: 80)
                    
                }.padding()
                if viewModel.isLoading{
                    ProgressView()
                }
            }.edgesIgnoringSafeArea(.all)
            
        }.navigationBarBackButtonHidden(true)
        .accentColor(.white)
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
