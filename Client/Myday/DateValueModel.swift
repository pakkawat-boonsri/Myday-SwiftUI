//
//  DateValueModel.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 9/9/2565 BE.
//

import Foundation

struct DateValue: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
