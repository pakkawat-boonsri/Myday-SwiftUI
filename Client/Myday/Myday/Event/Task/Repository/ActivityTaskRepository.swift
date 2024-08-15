//
//  ActivityTaskRepository.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 5/10/2565 BE.
//

import Foundation

class ActivityTaskRepository: TaskRepositoryProtocol {
    
    let remoteDataSource: ActivityTaskDatasouce
    
    init(dataSource: ActivityTaskDatasouce) {
        self.remoteDataSource = dataSource
    }
    
    func fetchEventList(date: Day, dateTime: Date,completion: @escaping ([TaskEntity], Bool) -> Void) {
        remoteDataSource.fetchData(dateTime: dateTime) { activity, status in
            
            guard let dataAct: [Activity] = activity else { return completion([],false) }
            
            let dataActEntity: [TaskEntity] =  dataAct.compactMap { item in
                TaskEntity(type: .activity,
                           name: rsaUser.decryptData(text: item.name ?? ""),
                           startTime: DateFormat().getLongFormatTime(data: DateFormat().stringDateToDateTime(isoDate: item.startdate ?? "")),
                           endTime: DateFormat().getLongFormatTime(data: DateFormat().stringDateToDateTime(isoDate: item.enddate ?? "")),
                           location: rsaUser.decryptData(text: item.location ?? ""),
                           lecturer: "",
                           description: rsaUser.decryptData(text: item.description ?? ""))
            }
            
//            // debugPrint("dataActEntity = ", dataActEntity)
            
            var result: [TaskEntity] = []
            result.append(contentsOf: dataActEntity)
            
            completion(result,true)
        }
    }
}
