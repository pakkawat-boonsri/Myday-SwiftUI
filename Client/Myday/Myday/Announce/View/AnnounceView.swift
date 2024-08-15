//
//  AnnounceView.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 9/9/2565 BE.
//

import SwiftUI
import SkeletonUI
import AlertToast

struct AnnounceView: View {
    
    @State var index = 0
    @State var isShowActivityDocu: Bool = false
    @State var isShowSeeAllAnnouce: Bool = false
    @State var refresh: Bool = false
    @State var error: Bool = false
    @StateObject var viewModel = AnnounceViewModel(role: userInfo?.role ?? .nisit)

    private var role: Role!
    
    init() {
        if let role = userInfo?.role {
            self.role = role
        }
    }

    var body: some View {
        VStack{
            ScrollView(.vertical) {
                
                VStack(alignment: .leading){
                    
                    VStack{
                        HStack(spacing: 5){
                            VStack{
                                Image("Announce")
                                    .resizable()
                            }
                            .frame(width: 30,height: 30)
                            VStack{
                                Text(NSLocalizedString("Announce", comment: "Announce"))
                                    .modifier(Fonts(fontName: .medium, size: 24))
                            }
                            .frame(height: 30)
                            
                            
                            if self.role == .admin {
                                Button {
                                    self.isShowSeeAllAnnouce = true
                                } label: {
                                    VStack{
                                        NavigationLink(destination: SeeAllAnnounceView(),isActive: $isShowSeeAllAnnouce) {
                                            EmptyView()
                                        }
                                        
                                        Text("See all")
                                            .foregroundColor(.white)
                                            .modifier(Fonts(fontName: .medium, size: 14))
                                            .padding(.horizontal,10)
                                    }
                                    .background(
                                        Capsule()
                                            .foregroundColor(Color("02BC77"))
                                    )
                                }
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity)
                    .background(.white)

                    TabView(selection: self.$index) {
                        if viewModel.new.count > 0 {
                            ForEach(0...viewModel.new.count - 1,id: \.self) { index in
                                AsyncImage(url: URL(string: viewModel.new[index].image)) { image in
                                    image
                                        .resizable()
                                        .cornerRadius(5)
                                        .padding(.horizontal)
                                        .tag(index)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        } else {
                            ProgressView()
                        }
                    }
                    .frame(height:230)
                    .padding(.top)
                    .tabViewStyle(PageTabViewStyle())
                    .shadow(radius: 2)
                    
                    VStack{
                        HStack(spacing: 5){
                            VStack{
                                Image("Classes")
                                    .resizable()
                            }
                            .frame(width: 25,height: 25)
                            VStack{
                                if self.role == .admin {
                                    Text(NSLocalizedString("Activity", comment: "Activity"))
                                        .modifier(Fonts(fontName: .medium, size: 24))
                                } else {
                                    Text(NSLocalizedString("Classes_Schedule", comment: "Classes Schedule"))
                                        .modifier(Fonts(fontName: .medium, size: 24))
                                }
                                
                            }
                            .frame(height: 30)
                            
                             
                            if self.role == .admin {
                                Button {
                                    self.isShowActivityDocu = true
                                } label: {
                                    VStack{
                                        NavigationLink(destination: ActivityDocumentView(type: .create,currentActivity: nil),isActive: $isShowActivityDocu) {
                                            EmptyView()
                                        }
                                        Text("Add")
                                            .foregroundColor(.white)
                                            .modifier(Fonts(fontName: .medium, size: 14))
                                            .padding(.horizontal)
                                    }
                                    .background(
                                        Capsule()
                                            .foregroundColor(Color("FEB744"))
                                    )
                                }
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .padding(.top)
                    
                    LazyVStack{
                        if role == .nisit {
                            ForEach(0...viewModel.subject.count - 1,id: \.self){ index in
                                    ClassesView(data: viewModel.subject[index])
                                }
                            
                        } else if role == .admin {
                            if viewModel.activity.count > 0{
                                ForEach(0...viewModel.activity.count - 1,id: \.self){ index in
                                    VStack{
                                        NavigationLink(destination: ActivityDocumentView(type: .edit, currentActivity: viewModel.activity[index])) {
                                            ActivityTableView(data: viewModel.activity[index])
                                        }
                                    }
                                }
                            } else {
                                VStack{
                                    Image("onActivity")
                                        .resizable()
                                        .frame(width: 220,height: 220)
                                    
                                    Text("No Activity")
                                        .modifier(Fonts(fontName: .semiBold, size: 18))
                                        .foregroundColor(Color("7E7E7E"))
                                        .opacity(0.7)
                                        .frame(minWidth:0, maxWidth: .infinity)
                                }
                                .padding(.top)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 50)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top)
            }
        }
        .toast(isPresenting: $refresh){
            AlertToast(displayMode: .hud, type: .complete(Color("02BC77")), title: "Refresh success")
        }
        .toast(isPresenting: $error){
            AlertToast(displayMode: .hud, type: .error(Color("D9534F")), title: "Refresh error")
        }
        .refreshable {
            viewModel.fetchData(role: self.role){ status in
                if status {
                    self.refresh = true
                } else {
                    self.error = true
                }
                self.viewModel.statusApi = status
            }
        }
    }
    
    func getColor(data: Day) -> Color {
        switch(data) {
        case .mon :
            return Color("FFD950")
        case .tue :
            return Color("D9534F").opacity(0.8)
        
        case .wed :
            return Color("02BC77").opacity(0.8)
          
        case .thu :
            return Color("FEB744")
        
        case .fri :
            return Color("1E70CD").opacity(0.8)
          
        case .sat:
            return .purple
            
        case .sun:
            return .red
        }
    }
        
    func getDay(data: Day) -> String {
        switch(data) {
        case .mon :
            return "MON"
          
        case .tue :
            return "TUE"
          
        case .wed :
            return "WED"
            
        case .thu :
            return "THU"
         
        case .fri :
            return "FRI"
            
        case .sat:
            return "SAT"
            
        case .sun:
            return "SUN"
        }
    }
    
    @ViewBuilder
    func ActivityTableView(data: ActivityEntity) -> some View {
        VStack{
            VStack(alignment: .leading){
                Text(data.name)
                    .skeleton(with: viewModel.statusApi == false, size: CGSize(width: 230, height: 18))
                    .modifier(Fonts(fontName: .bold, size: 18))
                

                Text(DateFormat().dateConvert(startDate: data.startDate, endDate: data.endDate))
                    .skeleton(with: viewModel.statusApi == false, size: CGSize(width: 150, height: 18))
                    .modifier(Fonts(fontName: .medium, size: 12))
                    .foregroundColor(Color("7E7E7E"))
              
                Text(NSLocalizedString("location", comment: "location") + " : " + data.location)
                    .skeleton(with: viewModel.statusApi == false, size: CGSize(width: 150, height: 18))
                    .modifier(Fonts(fontName: .medium, size: 15))
                
            }
            .padding([.leading,.top])
            Spacer()
        }
        .frame(height: 125)
        .frame(maxWidth: .infinity,alignment: .leading)
        .background(.white)
        .cornerRadius(5)
        .shadow(color: .gray, radius: 1, x: 0, y: 1)
    }
    
    @ViewBuilder
    func ClassesView(data: SubjectEntity) -> some View {
        HStack{
            VStack(alignment: .leading, spacing: 5){
                Text(getDay(data: data.date))
                    .modifier(Fonts(fontName: .medium, size: 10))
                    .padding(.top,3)
                Text(data.startTime + " - " + data.endTime)
                    .modifier(Fonts(fontName: .medium, size: 13))
                Spacer()
            }
            .skeleton(with: viewModel.statusApi == false)
            .shape(type: .rectangle)
            .frame(width: 100)
            .background(self.getColor(data: data.date))
            .cornerRadius(5)

            
            VStack(alignment: .leading){
                Text(data.name)
                    .skeleton(with: viewModel.statusApi == false, size: CGSize(width: 230, height: 15))
                    .modifier(Fonts(fontName: .medium, size: 14))
                    .lineLimit(1)
                    .padding(.top,3)
                Text(data.id + " sec " + data.sec)
                    .skeleton(with: viewModel.statusApi == false, size: CGSize(width: 100, height: 15))
                    .modifier(Fonts(fontName: .medium, size: 10))
                Spacer()
                HStack{
                    Spacer()
                    VStack{
                        Text("Room " + data.room)
                            .skeleton(with: viewModel.statusApi == false, size: CGSize(width: 60, height: 15))
                            .modifier(Fonts(fontName: .medium, size: 10))
                    }
                    .padding(.bottom,5)
                }
            }
            .padding(.horizontal,2)
            Spacer()
        }
        .frame(height: 80)
        .background(.white)
        .cornerRadius(5)
        .shadow(color: .gray, radius: 1, x: 0, y: 1)
    }
}

struct AnnounceView_Previews: PreviewProvider {
    static var previews: some View {
        AnnounceView()
    }
}

struct Class: Identifiable {
    var id = UUID().uuidString
    let day: String
    let color: Color
    let time: String
    let nameSubject: String
    let detail: String
    let room: String
}




