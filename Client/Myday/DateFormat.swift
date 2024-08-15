//
//  DateFormat.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 8/8/2565 BE.
//

import Foundation

public class DateFormat  {
    
    public init() {}
    
    public func isSameDay(data1: Date, data2: Date) -> Bool {
        let calendar = Calendar.current
        
        return calendar.isDate(data1, inSameDayAs: data2)
    }
    
    public func isDateInToday(data: Date) -> Bool {
        let calendar = Calendar.current
        
        return calendar.isDateInToday(data)
    }
    
    public func isDateInWeekend(data: Date) -> Bool {
        let calendar = Calendar.current
        
        return calendar.isDateInWeekend(data)
    }
    
    public func isDateInTomorrow(data: Date) -> Bool {
        let calendar = Calendar.current
        
        return calendar.isDateInTomorrow(data)
    }
    
    public func isDateInYesterday(data: Date) -> Bool {
        let calendar = Calendar.current
        
        return calendar.isDateInYesterday(data)
    }
    
    public func getLongFormatDay(data: Date) -> String {
        
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "YYYY"
        
        return yearFormatter.string(from: data)
    }
    
    public func getLongFormatMount(data: Date) -> String {
        let mountFormatter = DateFormatter()
        mountFormatter.dateFormat = "MMMM"
        
        return mountFormatter.string(from: data)
    }
    
    public func getLongFormatYear(data: Date) -> String {
        
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "YYYY"
        
        return yearFormatter.string(from: data)
    }
    
    public func getLongFormatTime(data: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"

        return formatter.string(from: data)
    }
    
    public func dateConvert(startDate: Date , endDate: Date) -> String {
        
        if self.isSameDay(data1: startDate, data2: endDate) {
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMM YYYY"
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            
            let dateString = formatter.string(from: startDate)
            let startTimeString = timeFormatter.string(from: startDate)
            let endTimeString = timeFormatter.string(from: endDate)
            return dateString + " " + NSLocalizedString("at_time", comment: "at") + " " + startTimeString + " - " + endTimeString
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMM"
            
            let yearFormatter = DateFormatter()
            yearFormatter.dateFormat = "YYYY"
            
            let startDateString = dateFormatter.string(from: startDate)
            let endDateString = dateFormatter.string(from: endDate)
            let yearDateString = yearFormatter.string(from: endDate)
            
            return startDateString + " - " + endDateString + " " + yearDateString
            
        }
    }
    public func timeStringToDate(item: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let date = dateFormatter.date(from: item)!
        
        return date
    }
    public func stringToDate(isoDate: String?) -> Date {
        
        guard let str = isoDate else { return Date() }

        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatterGet.locale = Locale(identifier: "en_US")
        
        let date = dateFormatterGet.date(from: str)!
        
        return date
    }
    
    public func stringTimeToDateTime(isoDate: String?) -> Date {
        
        guard let str = isoDate else { return Date() }

        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "HH:mm"
        dateFormatterGet.locale = Locale(identifier: "en_US")

        let date = dateFormatterGet.date(from: str)!
        
        return date
    }
    
    public func stringDateToDateTime(isoDate: String?) -> Date {
        
        guard let str = isoDate else { return Date() }

        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm"
        
        let item = dateFormatterGet.date(from: str)!

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
         
        let result = dateFormatter.string(from: item)
        
        let dateFormatterTime = DateFormatter()
        dateFormatterTime.dateFormat = "HH:mm"
        
        let date = dateFormatterTime.date(from: result)!
        
        return date
    }
    public func longDateToString(date: Date) -> String {

        // Create Date Formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//        dateFormatter.locale = Locale(identifier: "en_US")
        
        // Convert Date to String
        return dateFormatter.string(from: date)
    }
    
    public func dateToString(date: Date) -> String {

        // Create Date Formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.locale = Locale(identifier: "en_US")
        
        // Convert Date to String
        return dateFormatter.string(from: date)
    }
    
    public func dateToStringShot(date: Date) -> String {

        // Create Date Formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US")

        // Convert Date to String
        return dateFormatter.string(from: date)
    }
    
    func isWorkDay(day: Date, workDay: [ClassDay]) -> Bool {
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "E"
        dayFormatter.locale = Locale(identifier: "en_US")
        
        switch(dayFormatter.string(from: day)){
        case "Mon":
            return (workDay.first(where: { $0.day == .mon }) != nil)
        case "Tue":
            return (workDay.first(where: { $0.day == .tue }) != nil)
        case "Wed":
            return (workDay.first(where: { $0.day == .wed }) != nil)
        case "Thu":
            return (workDay.first(where: { $0.day == .thu }) != nil)
        case "Fri":
            return (workDay.first(where: { $0.day == .fri }) != nil)
        default:
            return false
        }
    }
    
    func WorkDay(day: Date) -> Day {
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "E"
        dayFormatter.locale = Locale(identifier: "en_US")
        
        switch(dayFormatter.string(from: day)) {
        case "Mon":
            return .mon
        case "Tue":
            return .tue
        case "Wed":
            return .wed
        case "Thu":
            return .thu
        case "Fri":
            return .fri
        case "Sat":
            return .sat
        case "Sun":
            return .sun
        default:
            return .mon
        }
    }
    
}
