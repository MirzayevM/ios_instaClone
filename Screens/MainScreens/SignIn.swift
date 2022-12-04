//
//  SignIn.swift
//  ios_instaClone
//
//  Created by Mirzabek on 01/11/22.
//

import SwiftUI

struct SignIn: View {
    
    @State var loading = false
    @ObservedObject var viewModel = SignInViewModel()
    @State var email = "mirzabekmirzayev1@gmail.com"
    @State var password = "1234567mMn!"
    @State var isEmail = false
    @State var isPassword = false
    
    //signIn function
    func doSignIn(){
        if email.isValidEmail && password.isValidPassword {
            isEmail = false
            isPassword = false
            viewModel.apiSignIn(email: email, password: password, completion: { result in
                if !result {
                    print("Check email or password")
                    return
                }
            })
        }
        if email.isValidEmail == false{
            isEmail = true
        } else { isEmail = false}
        if password.isValidPassword == false {
            isPassword = true
        } else { isPassword = false}
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Utils.color1,Utils.color2]), startPoint: .bottom, endPoint: .top)
                
                VStack(spacing: 10){
                    Spacer()
                    Text("app_name").foregroundColor(.white).font(Font.custom("Billabong", size: 45))
                    //email text field
                    VStack(){
                        HStack(){
                            Image(systemName: "person.fill.checkmark").foregroundColor(.white).padding(.leading,10)
                            TextField("email", text: $email)
                                .foregroundColor(Color.white)
                                .padding()
                                .frame(height: 50)
                               
                                .cornerRadius(10)
                        }.background(Color.white.opacity(0.4)).cornerRadius(15)
                        if isEmail {
                            
                            Text("error_email")
                                .foregroundColor(.black)
                                .font(.system(size: 15))
                        }
                    }
                    
                    // Password Text Field
                    VStack{
                       
                        HStack{
                            Image(systemName: "key").foregroundColor(.white).padding(.leading,10)
                            SecureField("password", text: $password)
                                .foregroundColor(Color.white)
                                .padding()
                                .frame(height: 50)
                                
                                .cornerRadius(10)
                            
                        }.background(Color.white.opacity(0.4)).cornerRadius(15)
                        if isPassword {
                            Text("error_password")
                                .foregroundColor(.black)
                                .font(.system(size: 15))
                        }
                    }
                    //SignIN button
                    Button(action: {
                        doSignIn()
                    }, label: {
                        Text("sign_in").foregroundColor(.white).frame(maxWidth: .infinity).padding().background(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 1.5)).foregroundColor(.white.opacity(0.4))
                    }).padding(.top,10)
                    Spacer()
                    //bottom button
                    VStack{
                       
                        HStack{
                            Text("dont_have_account").foregroundColor(.white)
                            NavigationLink(
                                destination: SignUp() ,
                                label: {
                                    Text("sign_up").foregroundColor(.white).fontWeight(.bold)
                                })
                        }
                    }.frame(maxWidth:.infinity).frame(maxHeight: 80)
                    
                }.padding()
                if viewModel.isLoading{
                    ProgressView()
                }
            }
            .edgesIgnoringSafeArea(.all)
            
        }
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
    }
}



extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "^[A-Z0-9a-z][a-zA-Z0-9_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}

extension String {
    var isValidPassword: Bool {
        NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Z])(?=.*[a-z])(?=.*?[0-9])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}").evaluate(with: self)
    }
}
