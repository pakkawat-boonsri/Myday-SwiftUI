//
//  SigninView.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 15/9/2565 BE.
//

import SwiftUI
import AlertToast


struct SigninView: View {
    

    @StateObject private var viewModel = SigninViewModel()
    @State private var isShowingSignUpView = false
    @State private var isShowingContentView = false
    @State private var isShowError: Bool = false
    
    @FocusState private var emailIsFocused: Bool
    @FocusState private var passwordIsFocused: Bool
    
    var body: some View {
        
        VStack {
            VStack {
                Image("logoapp")
//                    .resizable()
//                    .frame(width: 160, height: 128)
                    .background(.white)
            }
                
            ZStack(){
                Rectangle()
                    .frame( height: 1)
                    .foregroundColor(Color("7985CC"))
                    .cornerRadius(5)
                        
                    
                VStack{
                    Text("Sign In")
                        .modifier(Fonts(fontName: .medium, size:24))
                        .foregroundColor(Color("7985CC"))
                        .padding(.horizontal)
                }
                .background(.white)
            }
            .padding(.horizontal,60)
            
            
            VStack(spacing:10){
                
                VStack{
                    HStack{
                        VStack{
                            Image(systemName: "envelope")
                        }
                        .frame(width: 20)
                        TextField("Email", text: $viewModel.email)
                            .focused($emailIsFocused)
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
                            .focused($passwordIsFocused)
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
            }
            .padding(.horizontal,40)
            .padding(.vertical)
            
            
            
            Button {
                self.emailIsFocused = false
                self.passwordIsFocused = false
                
                self.viewModel.signIn() { status in
                    self.isShowError = (status == false)
                    self.isShowingContentView = status
                }
            } label: {
                VStack{
                    Text("Sign In")
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
                    Text("Don’t have an account yet?")
                        .modifier(Fonts(fontName: .regular, size:14))
                        .foregroundColor(Color("7985CC"))
                    
                    Button {
                        self.isShowingSignUpView = true
                    } label: {
                        Text("Create")
                            .modifier(Fonts(fontName: .medium, size:16))
                            .foregroundColor(Color("374195"))
                    }
                }
                .padding(.leading,30)
                .padding(.bottom,30)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            
            NavigationLink(destination: SignUpView(), isActive: $isShowingSignUpView){
                EmptyView()
            }
            .navigationBarHidden(true)
            
            NavigationLink(destination: MyDayContentView()
                                            .navigationTitle("")
                                            .navigationBarHidden(true)
                           , isActive: $isShowingContentView) {
                EmptyView()
            }
            .navigationBarHidden(true)
            
        }
        .toast(isPresenting: $isShowError){
            AlertToast(displayMode: .banner(.pop), type: .error(Color("D9534F")), title: viewModel.errormasage)
        }
    }
}
