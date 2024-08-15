//
//  MyDayContentView.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 18/9/2565 BE.
//

import SwiftUI

struct MyDayContentView: View {
    
    @State var isActive = false
    @StateObject var viewModel = MyDayContentViewModel()
    @State var index = 0
    
    
    init() {
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().isOpaque = false
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.init(name: "IBMPlexSansThai-Bold", size: 12)! ], for: .normal)
    }
    
    var body: some View {
        NavigationView {
            if user != nil && isActive {
                if viewModel.status {
                    ContentApp()
                } else {
                    SigninView()
                        .preferredColorScheme(.light)
                }
            } else {
                MydayLoadingView()
                    .preferredColorScheme(.light)
                    .onAppear {
//                        if user != nil {
//                            self.isActive = true
//                        } else {
//                        viewModel.ex()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            self.isActive = true
                        }
//                        }
                    }
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        

    }
    
    @ViewBuilder
    func ContentApp() -> some View {
        TabView(selection: $index) {
            AnnounceView()
                .preferredColorScheme(.light)
                .foregroundColor(.black)
                .tabItem {
                    Image(systemName: "megaphone.fill")
                        .foregroundColor(index == 0 ? Color("FEB744") : .secondary)
                    Text(NSLocalizedString("Announce", comment: "Announce"))

                }
                .tag(0)

            ActivityView()
                .preferredColorScheme(.light)
                .foregroundColor(.black)
                .tabItem {
                    Image(systemName: "calendar.badge.clock")
                        .foregroundColor(index == 1 ? Color("FEB744") : .secondary)
                    Text(NSLocalizedString("event", comment: "event"))
                        .modifier(Fonts(fontName: .bold, size: 12))
                }
                .tag(1)
            
            
            ProfileView()
                .preferredColorScheme(.light)
                .foregroundColor(.black)
                .tabItem {
                    Image(systemName: "person.fill")
                        .foregroundColor(index == 2 ? Color("FEB744") : .secondary)
                    Text(NSLocalizedString("profile", comment: "profile"))
                        .modifier(Fonts(fontName: .bold, size: 12))
                }
                .tag(2)
        }
        .accentColor(Color("FEB744"))
    }
}

struct MyDayContentView_Previews: PreviewProvider {
    static var previews: some View {
        MyDayContentView()
    }
}



