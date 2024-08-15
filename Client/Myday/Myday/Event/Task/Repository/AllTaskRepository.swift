//
//  TaskRepository.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 5/10/2565 BE.
//


import Foundation

class AllTaskRepository: TaskRepositoryProtocol  {

    let remoteDataSource: AllTaskDatasouce
    
    init(dataSource: AllTaskDatasouce) {
        self.remoteDataSource = dataSource
    }
    
    func fetchEventList(date: Day, dateTime: Date,completion: @escaping ([TaskEntity], Bool) -> Void) {
        remoteDataSource.fetchData(date: date, dateTime: dateTime) { activity, subject, status in
            
            guard let dataAct: [Activity] = activity else { return completion([],false) }
            guard let dataSub: [Subject] = subject else { return completion([],false) }
            
            let dataActEntity: [TaskEntity] =  dataAct.compactMap { item in
                TaskEntity(type: .activity,
                           name: rsaUser.decryptData(text: item.name ?? ""),
                           startTime: DateFormat().getLongFormatTime(data: DateFormat().stringDateToDateTime(isoDate: item.startdate ?? "")),
                           endTime: DateFormat().getLongFormatTime(data: DateFormat().stringDateToDateTime(isoDate: item.enddate ?? "")) ,
                           location: rsaUser.decryptData(text: item.location ?? ""),
                           lecturer: "",
                           description: rsaUser.decryptData(text: item.description ?? "test"))
            }
            
//            // debugPrint("dataActEntity = ", dataActEntity)
            
            let dataSubEntity: [TaskEntity] =  dataSub.compactMap { item in
                TaskEntity(type: .course,
                           name: rsaUser.decryptData(text: item.name ?? "") ,
                           startTime: DateFormat().getLongFormatTime(data: DateFormat().stringTimeToDateTime(isoDate: item.startTime ?? "")),
                           endTime: DateFormat().getLongFormatTime(data: DateFormat().stringTimeToDateTime(isoDate: item.endTime ?? "")),
                           location: rsaUser.decryptData(text: item.room ?? ""),
                           lecturer: rsaUser.decryptData(text: item.lecturer ?? ""),
                           description: "")
            }
            
//            // debugPrint("dataSubEntity = ", dataSubEntity)
            
            var result: [TaskEntity] = []
            result.append(contentsOf: dataActEntity)
            result.append(contentsOf: dataSubEntity)
            
            completion(result,true)
        }
    }
}
