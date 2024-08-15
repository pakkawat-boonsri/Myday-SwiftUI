//
//  ClassTaskRepository.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 5/10/2565 BE.
//

import Foundation

class ClassTaskRepository: TaskRepositoryProtocol {
    
    let remoteDataSource: ClassTaskDatasouce
    
    init(dataSource: ClassTaskDatasouce) {
        self.remoteDataSource = dataSource
    }
    
    func fetchEventList(date: Day, dateTime: Date,completion: @escaping ([TaskEntity], Bool) -> Void) {
        remoteDataSource.fetchData(date: date) { subject, status in
            
            guard let dataSub: [Subject] = subject else { return completion([],false) }
            
            let dataSubEntity: [TaskEntity] =  dataSub.compactMap { item in
                TaskEntity(type: .course,
                           name: rsaUser.decryptData(text: item.name ?? ""),
                           startTime: DateFormat().getLongFormatTime(data: DateFormat().stringTimeToDateTime(isoDate: item.startTime ?? "")),
                           endTime: DateFormat().getLongFormatTime(data: DateFormat().stringTimeToDateTime(isoDate: item.endTime ?? "")),
                           location: rsaUser.decryptData(text: item.room ?? ""),
                           lecturer: rsaUser.decryptData(text: item.lecturer ?? ""),
                           description: "")
            }
            
            var result: [TaskEntity] = []
            result.append(contentsOf: dataSubEntity)
            
            completion(result,true)
        }
    }
}
