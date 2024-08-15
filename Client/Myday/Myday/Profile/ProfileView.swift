//
//  ProfileView.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 17/9/2565 BE.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel = ProfileViewModel()
    @State var isShowingSigninView: Bool = false
    
    var body: some View {
        
        ZStack {
            VStack{
                headerView()
                
                Spacer()
            }
            
            VStack{
                Text("Profile")
                    .padding(.top,50)
                    .foregroundColor(.white)
                    .modifier(Fonts(fontName: .medium, size:36))
                Spacer()
            }
            
            VStack{
                ProfileBox()
                        .padding(.top,110)
                
                VStack{
                    HStack{
                        Image(systemName: "envelope.fill")
                            .resizable()
                            .frame(width: 30,height: 25)
                            
                        Text(viewModel.user)
                            .modifier(Fonts(fontName: .medium, size:24))
                    }
                    
                }
                .frame(width: 315,height: 60)
                .background(.white)
                .cornerRadius(15)
                .shadow(radius: 3)
                .padding(.top,6)
                
                Button{
                    
                } label: {
                    HStack{
                        Text("Activity List")
                            .modifier(Fonts(fontName: .medium, size:24))
                            .foregroundColor(.white)
                            .padding(.leading,20)
                        
                        Spacer()
                        
                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: 25,height: 20)
                            .foregroundColor(.white)
                            .padding()
                    }
                    .frame(width: 315,height: 60)
                    .background(Color("FEB744"))
                    .cornerRadius(15)
                    .shadow(radius: 3)
                }
                .padding(.top,6)
                
                
                Spacer()
            }
            
            VStack {
                Spacer()
                
                Button {
                    viewModel.signOut() { status in
                        self.isShowingSigninView = status
                    }
                } label: {
                    HStack{
                        Text("Sign Out")
                            .modifier(Fonts(fontName:.medium,size:20))
                            .foregroundColor(.white)
                    }
                    .frame(width: 150,height: 50)
                    .background(Color("FEB744"))
                    .cornerRadius(15)
                    .shadow(radius: 3)
                    
                }
            }
            .padding(.bottom)
            
            NavigationLink(destination: SigninView()
                                            .navigationTitle("")
                                            .navigationBarHidden(true)
                           , isActive: $isShowingSigninView) {
                EmptyView()
            }
            .navigationBarHidden(true)
            
            
            
            
        }
        .edgesIgnoringSafeArea(.top)
    }
    
    @ViewBuilder
    func headerView() -> some View {
        Rectangle()
            .frame(height: 230)
            .cornerRadius(30)
            .foregroundColor(Color("FEB744"))
    }
    
    @ViewBuilder
    func ProfileBox() -> some View {
        VStack{
            VStack{
                AsyncImage(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/myday-project.appspot.com/o/palm.png?alt=media&token=74f4661d-7271-48f8-b0ea-264e26062563")) { image in
                    image
                        .resizable()
                        .cornerRadius(5)
                } placeholder: {
                    ProgressView()
                }
            }
            .frame(width: 140,height: 160)
            .padding(.top,20)
            
            Text("Pakkawat Boonsri")
                .modifier(Fonts(fontName: .medium, size: 23))
                .padding(.vertical)
        }
        .frame(width: 300)
        .background(.white)
        .cornerRadius(15)
        .shadow(radius: 3)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
