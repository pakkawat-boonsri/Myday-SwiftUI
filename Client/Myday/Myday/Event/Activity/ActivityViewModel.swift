//
//  EventViewModel.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 6/8/2565 BE.
//

import Foundation

class ActivityViewModel: ObservableObject {
    
    @Published private(set) var mountData: String = ""
    @Published private(set) var yearData: String = ""
    @Published private(set) var currentMonth: Int = 0
    @Published private(set) var filterData: FilterActivity = .all
    
    init(){
        self.setDataDate(currentDate: Date())
    }
    
    func setDataDate(currentDate: Date){
        
        self.mountData = DateFormat().getLongFormatMount(data: currentDate)
        self.yearData = DateFormat().getLongFormatYear(data: currentDate)
    }
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else{
            return Date()
        }
        
        return currentMonth
    }
    
    func extractDate() -> [DateValue] {
        let calendar = Calendar.current
        let currentMonth = getCurrentMonth()
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
        
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1{
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        return days
    }
    
    func backCurrentMonth(){
        currentMonth -= 1
    }
    
    func nextCurrentMonth(){
        currentMonth += 1
    }
    
    func setFilter(type: FilterActivity) {
        self.filterData = type
    }
    
}

extension Date {
    
    func getAllDates() -> [Date]{
        
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
    
        
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}

