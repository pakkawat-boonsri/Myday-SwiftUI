//
//  TaskEntity.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 5/10/2565 BE.
//

import Foundation


struct TaskEntity: Identifiable {
    var id = UUID().uuidString
    var type: FilterActivity
    var name: String
    var startTime: String
    var endTime: String
    var location: String
    
    var lecturer: String
    var description: String
    
}
