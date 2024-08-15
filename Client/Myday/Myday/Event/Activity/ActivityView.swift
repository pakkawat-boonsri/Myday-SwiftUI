//
//  ActivityView.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 6/8/2565 BE.
//

import SwiftUI

struct ActivityView: View {
    
    @State var currentDate: Date = Date()
    @State var selectDate: Date = Date()
    @State var extractDate: [DateValue] = []
    @State var isShowbutton: Bool = true
    
    @State var filterData: FilterActivity = .all
    
    @State var opacityFilter: CGFloat = 1
    @State var currentMonth: Int = 0
    
    @StateObject var viewModel = ActivityViewModel()

    var body: some View {
        ZStack(alignment: .top){
            VStack{
                HeadCalendarView().opacity(0)
                Spacer()
                ScrollView(.vertical, showsIndicators: false){
                    VStack{
                        CustomCalendarView(selectDate: $selectDate,extractDate: $extractDate,currentMonth: $currentMonth)
                                .background(.white)
                                .cornerRadius(0)
                                .shadow(color: .gray, radius: 1, x: 0, y: 2)
           
                        FilterView()
                            .overlay(
                                GeometryReader { reader -> Text in
                                    let offset = reader.frame(in: .global).minY
                                    if offset > 110 {
                                        self.opacityFilter = 0
                                    } else {
                                        self.opacityFilter = min(-(offset-110)/60, 1)
                                    }
                                    return Text("")
                                }
                            )
                    }
                    TaskView(selectDate: $selectDate,filter: $filterData)
                }
            }.onAppear(perform: setUpData)
            VStack(spacing: 0){
                HeadCalendarView()
                
                if opacityFilter > 0 {
                    VStack(spacing: 0){
                        Rectangle()
                            .frame(height: 1)
                            .opacity(0.5)
                        FilterView()
                    }
                    .opacity(self.opacityFilter)
                }
            }
        }
    }
 
    func setUpData(){
        extractDate = viewModel.extractDate()
    }
    
    
    @ViewBuilder
    func HeadCalendarView() -> some View{
        VStack{
            HStack(spacing: 20){
                HStack(spacing: 0) {
                    
                    Text(viewModel.mountData)
                        .padding(.trailing)
                        .modifier(Fonts(fontName: .bold, size: 20))
                    
                    
                    Text(viewModel.yearData)
                        .modifier(Fonts(fontName: .semiBold, size: 20))
                    
                    Spacer()
                        
                    
                }.padding([.horizontal,.top])
                Spacer(minLength: 0)
                
                if isShowbutton {
                    HStack{
                        Button {
                            withAnimation{
                                viewModel.backCurrentMonth()
                                self.currentMonth -= 1
                            }
                        } label: {
                            Image(systemName: "chevron.left").font(.title2.bold())
                        }
                        
                        Button {
                            withAnimation{
                                viewModel.nextCurrentMonth()
                                self.currentMonth += 1
                            }
                        } label: {
                            Image(systemName: "chevron.right").font(.title2.bold())
                                
                        }
                    }.padding(.horizontal)
                }
            }
        }.onChange(of: viewModel.currentMonth) { newValue in
            currentDate = viewModel.getCurrentMonth()
            if DateFormat().isDateInToday(data: currentDate) {
                selectDate = currentDate
            }
            viewModel.setDataDate(currentDate: currentDate)
            extractDate = viewModel.extractDate()
        }
    }
    
    @ViewBuilder
    func FilterView() -> some View {
        VStack{
            HStack{
                Text("ตัวกรอง")
                    .modifier(Fonts(fontName: .bold, size: 18))
        
                Button {
                    self.filterData = .all
                } label: {
                    ZStack{
                        if self.filterData == .all {
                            HStack(spacing: 0){
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .frame(width: 12,height: 12)
                                    .foregroundColor(.white)
                                    .padding(.leading,5)
                                    
                                Text(NSLocalizedString("filter_all", comment: "All"))
                                    .modifier(Fonts(fontName: .medium, size: 12))
                                    .foregroundColor(.white)
                                    .padding(.horizontal,10)
                                    .padding(.vertical,1)
                            }
                        } else {
                            Text(NSLocalizedString("filter_all", comment: "All"))
                                .modifier(Fonts(fontName: .medium, size: 12))
                                .foregroundColor(Color("7985CC"))
                                .padding(.horizontal,10)
                                .padding(.vertical,1)
                                .background(
                                        Capsule()
                                        .foregroundColor(.white)
                                )
                        }
                    }
                    .padding(2)
                    .background(
                        Capsule()
                        .foregroundColor(Color("7985CC"))
                    )
                }
                
                Button {
                    self.filterData = .course
                } label: {
                    ZStack{
                        if self.filterData == .course {
                            HStack(spacing: 0){
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .frame(width: 12,height: 12)
                                    .foregroundColor(.white)
                                    .padding(.leading,5)
                                
                                Text(NSLocalizedString("filter_course", comment: "Course"))
                                    .modifier(Fonts(fontName: .medium, size: 12))
                                    .foregroundColor(.white)
                                    .padding(.horizontal,10)
                                    .padding(.vertical,1)
                            }
                        } else {
                            Text(NSLocalizedString("filter_course", comment: "Course"))
                                .modifier(Fonts(fontName: .medium, size: 12))
                                .foregroundColor(Color("FEB744"))
                                .padding(.horizontal,10)
                                .padding(.vertical,1)
                                .background(
                                        Capsule()
                                            .foregroundColor(.white)
                                )
                        }
                    }
                    .padding(2)
                    .background(
                        Capsule()
                        .foregroundColor(Color("FEB744"))
                    )
                }
                
                Button {
                    self.filterData = .activity
                } label: {
                    ZStack{
                        if self.filterData == .activity {
                            HStack(spacing: 0){
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .frame(width: 12,height: 12)
                                    .foregroundColor(.white)
                                    .padding(.leading,5)
                                
                                Text(NSLocalizedString("filter_activity", comment: "Activity"))
                                    .modifier(Fonts(fontName: .medium, size: 12))
                                    .foregroundColor(.white)
                                    .padding(.horizontal,10)
                                    .padding(.vertical,1)
                            }
                        } else {
                            Text(NSLocalizedString("filter_activity", comment: "Activity"))
                                .modifier(Fonts(fontName: .medium, size: 12))
                                .foregroundColor(Color("02BC77"))
                                .padding(.horizontal,10)
                                .padding(.vertical,1)
                                .background(
                                        Capsule()
                                            .foregroundColor(.white)
                                )
                        }
                    }
                    .padding(2)
                    .background(
                        Capsule()
                        .foregroundColor(Color("02BC77"))
                    )
                }
                
                Spacer()
            }
        }
        .padding(.vertical,5)
        .padding(.leading)
        .background(.white)
        .cornerRadius(0)
        .shadow(color: .gray, radius: 1, x: 0, y: 2)
    }
}


struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
