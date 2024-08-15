//
//  TaskRepositoryProtocol.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 5/10/2565 BE.
//

import Foundation

protocol TaskRepositoryProtocol {
    func fetchEventList(date: Day, dateTime: Date,completion: @escaping (_ data: [TaskEntity], _ isStatusApi: Bool) -> Void)
}
