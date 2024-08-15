//
//  MydayLoadingView.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 4/10/2565 BE.
//

import SwiftUI

struct MydayLoadingView: View {
    
//    @Binding var isActive: Bool
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        VStack(spacing: 0){
            Spacer()

            VStack{
                Image("logoapp")
                    .resizable()
                    .frame(width: 160, height: 128)
                    .background(.white)
                Text("Start happy day with Myday.")
                    .modifier(Fonts(fontName: .semiBold, size: 20))
                    .foregroundColor(.secondary)
            }
            .scaleEffect(size)
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeIn(duration: 1.2)) {
                    self.size = 0.9
                    self.opacity = 1.0
                }
            }
            
//            NavigationLink(destination: SigninView()) {
//                VStack{
//                    Text("Back to SignIn")
//                        .modifier(Fonts(fontName: .semiBold, size: 20))
//                        .foregroundColor(.white)
//                        .padding(10)
//                }
//                .background(Color("D9534F"))
//                .cornerRadius(5)
//                .shadow(radius: 3)
//                .padding(.top)
//            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
//        .onAppear {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                self.isActive = true
//            }
//        }
    }
}

struct MydayLoadingView_Previews: PreviewProvider {
    
    static var previews: some View {
        MydayLoadingView()
    }
}
