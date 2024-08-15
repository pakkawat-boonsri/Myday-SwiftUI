//
//  CustomDatePickerSwiftUIView.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 6/8/2565 BE.
//

import SwiftUI

struct CustomCalendarView: View {
    
    @Binding var selectDate: Date
    @Binding var extractDate:[DateValue]
    @Binding var currentMonth: Int
    
    private let dateFormat = DateFormat()
    
    @StateObject var viewModel: CustomCalendarViewModel = CustomCalendarViewModel()
    var body: some View {
        
        VStack{
            HStack(spacing: 0){
                if let days = viewModel.days {
                    ForEach(days, id: \.self ){day in
                        Text(day)
                            .modifier(Fonts(fontName: .semiBold, size: 15))
                            .frame(maxWidth: .infinity)
                    }
                }

            }
                        
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            LazyVGrid(columns: columns,spacing: 0) {
                ForEach(extractDate){value in
                    
                    CardView(value: value)
                        .padding(.horizontal,8)
                        .onTapGesture {
                            selectDate = value.date
                        }
                }
            }
            Rectangle()
                .foregroundColor(Color("davyGrey"))
                .frame(width: 150, height: 4)
                .cornerRadius(20)
                .padding(.vertical)
        }
        .onChange(of: selectDate) { newValue in
            viewModel.selectDate = newValue
            viewModel.fetchData() { status in
                viewModel.status = status
            }
        }
        .onChange(of: currentMonth) { newValue in
            viewModel.setMont(num: newValue)
            
            viewModel.fetchData() { status in
                viewModel.status = status
            }
        }
    }
    
    
    @ViewBuilder
    func CardView(value: DateValue) -> some View {
        VStack{
            if value.day != -1,
                let textColor = dateFormat.isSameDay(data1: value.date, data2: selectDate) ? .white : (dateFormat.isDateInToday(data: value.date) ? Color("geraldine") : .black) {
                    Text("\(value.day)")
                        .modifier(Fonts(fontName: .semiBold, size: 15))
                        .foregroundColor(textColor)
                        .frame(maxWidth: .infinity)
                
                    Spacer(minLength: 0)
                
                if let task = viewModel.eventDate.first(where: { date in
                    return dateFormat.isSameDay(data1: value.date, data2: date)
                }){
                    Circle()
                        .fill(dateFormat.isSameDay(data1: task, data2: selectDate) ? .white : Color("02BC77"))
                    .frame(width: 8, height: 8)
                } else {
                    
                    if DateFormat().isWorkDay(day: value.date, workDay: viewModel.classDate) {
                        Circle()
                            .fill(dateFormat.isSameDay(data1: value.date, data2: selectDate) ? .white : Color("D9534F"))
                        .frame(width: 8, height: 8)
                    } else {
                        Spacer()
                    }
                    
                }
            }
            Spacer(minLength: 5)
        }
        .padding(.vertical,4)
        .background(
         Rectangle()
            .fill(Color("geraldine"))
            .cornerRadius(10)
            .opacity(dateFormat.isSameDay(data1: value.date, data2: selectDate) ? 1 : 0)
        )
    }
}

struct CustomCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
