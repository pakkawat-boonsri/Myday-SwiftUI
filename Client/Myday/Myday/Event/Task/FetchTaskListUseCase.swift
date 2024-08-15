//
//  FetchTaskListUseCase.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 5/10/2565 BE.
//

import Foundation


enum FilterActivity {
    case all
    case course
    case activity
}

class FetchTaskListUseCase {
    
    let repository: TaskRepositoryProtocol
    
    init(type: FilterActivity) {
        switch(type) {
        case .all:
            self.repository = AllTaskRepository(dataSource: AllTaskDatasouce())
        case .course:
            self.repository = ClassTaskRepository(dataSource: ClassTaskDatasouce())
        case .activity:
            self.repository = ActivityTaskRepository(dataSource: ActivityTaskDatasouce())
        }
    }
    
    func execute(date: Day, dateTime: Date,completion: @escaping (_ data: [TaskEntity], _ isStatusApi: Bool) -> Void) {
        repository.fetchEventList(date: date, dateTime: dateTime) { data, status in
            completion(data,status)
        }
    }
}
