//
//  AnnounceAdminEntity.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 27/9/2565 BE.
//

import SwiftUI

struct AnnounceAdminEntity {
    var new: [NewsEntity]
    var activity: [ActivityEntity]
}

struct ActivityEntity {
    var id: String
    var name: String
    var date: Date
    var description: String
    var location: String
    var startDate: Date
    var endDate: Date
}


