//
//  TaskModel.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 8/8/2565 BE.
//

import Foundation
import SwiftUI

struct Task: Identifiable{
    var id = UUID().uuidString
    var title: String
    var time: Date = Date()
    var room: String
    var teacher: String
}

struct TaskMetaData: Identifiable{
    var id = UUID().uuidString
    var task: [Task]
    var taskDate: Date
}

func getSample(offset: Int) -> Date {
    let calendar = Calendar.current
    
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    
    return date ?? Date()
}


