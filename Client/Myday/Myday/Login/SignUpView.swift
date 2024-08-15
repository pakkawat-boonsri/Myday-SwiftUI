//
//  SigninView.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 15/9/2565 BE.
//

import SwiftUI
import AlertToast

struct SignUpView: View {

    
    @StateObject private var viewModel = SignUpViewModel()
    @State private var isShowingSignInView = false
    @State private var comple: Bool = false
    @State private var error: Bool = false
    
    var body: some View {
        
        VStack {
                        
            HeadSignInView()
            
            VStack(spacing:10){
                
                VStack{
                    HStack {
                        HStack{
                            VStack{
                                Image(systemName: "person.fill")
                            }
                            .frame(width: 20)
                            VStack {
                                TextField("Firstname", text: $viewModel.firstname)
                                    .modifier(Fonts(fontName: .medium, size:16))
                                
//                                Rectangle()
//                                    .frame(height: 1)
//                                    .foregroundColor(Color("7985CC"))
                                
                                if (viewModel.isValidFirstName == false) && viewModel.isShowValid {
                                    HStack{
                                        Image(systemName: "exclamationmark.circle.fill")
                                            .resizable()
                                            .frame(width: 15, height: 15)
                                            .foregroundColor(.red)
                                            
                                        Text("Please fill your firstname.")
                                            .modifier(Fonts(fontName: .medium, size:10))
                                            .foregroundColor(.red)
                                        Spacer()
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                            }
                        }
                        
                        
                        HStack{
                                VStack{
                                Image(systemName: "person.fill")
                            }.frame(width: 20)
                            
                            VStack {
                                
                                TextField("Surname", text: $viewModel.surname)
                                    .modifier(Fonts(fontName: .medium, size:16))
                                
//                                Rectangle()
//                                    .frame( height: 1)
//                                    .foregroundColor(Color("7985CC"))
                                
                                if (viewModel.isValidSurname == false) && viewModel.isShowValid {
                                    HStack{
                                        Image(systemName: "exclamationmark.circle.fill")
                                            .resizable()
                                            .frame(width: 15, height: 15)
                                            .foregroundColor(.red)
                                            
                                        Text("Please fill your surname.")
                                            .modifier(Fonts(fontName: .medium, size:10))
                                            .foregroundColor(.red)
                                        Spacer()
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                            }
                    }
                }
            }
                
                VStack{
                    HStack{
                        VStack{
                            Image(systemName: "envelope")
                        }
                        .frame(width: 20)
                        TextField("Email", text: $viewModel.email)
                            .modifier(Fonts(fontName: .medium, size:16))
                    }.padding(.top)
                    Rectangle()
                        .frame( height: 1)
                        .foregroundColor(Color("7985CC"))
                        .cornerRadius(5)
                    
                    if (viewModel.isValidEmail == false) && viewModel.isShowValid {
                        HStack{
                            Image(systemName: "exclamationmark.circle.fill")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(.red)
                                
                            Text("Please fill your email.")
                                .modifier(Fonts(fontName: .medium, size:10))
                                .foregroundColor(.red)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(.bottom)
                
                VStack{
                    HStack{
                        VStack{
                            Image(systemName: "key")
                        }
                        .frame(width: 20)
                        SecureField("Password", text: $viewModel.password)
                            .modifier(Fonts(fontName: .medium, size:16))
                
                    }.padding(.top)
                    
                    Rectangle()
                        .frame( height: 1)
                        .foregroundColor(Color("7985CC"))
                        .cornerRadius(5)
                    
                    if (viewModel.isValidPassword == false) && viewModel.isShowValid {
                        HStack{
                            Image(systemName: "exclamationmark.circle.fill")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(.red)
                                
                            Text("Please fill your password.")
                                .modifier(Fonts(fontName: .medium, size:10))
                                .foregroundColor(.red)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(.bottom)
                
                VStack{
                    
                    HStack{
                        VStack{
                            Image(systemName: "key")
                        }
                        .frame(width: 20)
                        SecureField("Confirm Password", text: $viewModel.confirmPassword)
                            .modifier(Fonts(fontName: .medium, size:16))
                
                    }.padding(.top)
                    
                    Rectangle()
                        .frame( height: 1)
                        .foregroundColor(Color("7985CC"))
                        .cornerRadius(5)
                    
                    if viewModel.isShowValid && (viewModel.isValidConfirmPassword != .same) {
                        HStack{

                            Image(systemName: "exclamationmark.circle.fill")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(.red)
                                
                            if viewModel.isValidConfirmPassword == .empty {
                                Text("Please fill your confirm password.")
                                    .modifier(Fonts(fontName: .medium, size:10))
                                    .foregroundColor(.red)
                            } else {
                                Text("Password is different confirm password.")
                                    .modifier(Fonts(fontName: .medium, size:10))
                                    .foregroundColor(.red)
                            }
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                
            }
            .padding(.horizontal,40)
            .padding(.vertical)
            
            
            Button {
                viewModel.signUp() { token,status in
                    if status {
                        viewModel.createUserInfo(token: token) { result in
                            if result {
                                self.comple = true
                                self.error = false
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    self.isShowingSignInView = status
                                }
                            } else {
                                self.comple = false
                                self.error = true
                            }
                        }
                    } else {
                        self.comple = false
                        self.error = true
                    }
                }
            } label: {
                VStack{
                    Text("Sign Up")
                        .modifier(Fonts(fontName: .medium, size:18))
                        .foregroundColor(.white)
                        .padding(.vertical,10)
                }
                .frame(width: 200)
                .background(Color("brown"))
                .cornerRadius(10)
                .padding(.top)
            }
                
            Spacer()
            
            HStack{
                VStack(alignment: .leading, spacing:10){
                    Text("Already have an account?")
                        .modifier(Fonts(fontName: .regular, size:14))
                        .foregroundColor(Color("7985CC"))
                    
                    Button {
                        debugPrint("login tapped")
                        isShowingSignInView = true
                    } label: {
                        Text("Sign In")
                            .modifier(Fonts(fontName: .medium, size:16))
                            .foregroundColor(Color("374195"))
                    }
                    
                }
                .padding(.leading,30)
                .padding(.bottom,30)
               
                Spacer()
            }
            .frame(maxWidth: .infinity)
            
            NavigationLink(destination: SigninView(), isActive: $isShowingSignInView) {
                EmptyView()
            }
            .navigationBarHidden(true)
        }
        .toast(isPresenting: $comple){
            AlertToast(displayMode: .alert, type: .complete(Color("02BC77")), title: NSLocalizedString("create_user_success", comment: ""))
        }
        .toast(isPresenting: $error){
            AlertToast(displayMode: .alert, type: .error(Color("D9534F")), title: NSLocalizedString("create_user_error", comment: ""))
        }
    }
    
    @ViewBuilder
    func HeadSignInView() -> some View {
        VStack {
            Image("logoapp")
                .resizable()
                .frame(width: 160, height: 128)
                .background(.white)
        }
        .padding(.top)
            
        ZStack(){
            Rectangle()
                .frame( height: 1)
                .foregroundColor(Color("7985CC"))
                .cornerRadius(5)
                    
                
            VStack{
                Text("Sign Up")
                    .modifier(Fonts(fontName: .medium, size:24))
                    .foregroundColor(Color("7985CC"))
                    .padding(.horizontal)
            }
            .background(.white)
        }
        .padding(.horizontal,60)

    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
