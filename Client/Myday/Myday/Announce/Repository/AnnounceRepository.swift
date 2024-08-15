//
//  AnnounceRepository.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 21/9/2565 BE.
//

import Foundation
import SwiftUI

class AnnounceRepository: AnnounceRepositoryProtocol {
    
    let remoteDataSource: AnnounceDataSource
    
    init(dataSource: AnnounceDataSource) {
        self.remoteDataSource = dataSource
    }
    
    
    func fetchAnnounceNisitList(completion: @escaping (AnnounceNisitEntity?, Bool) -> Void) {
        remoteDataSource.fetchAnnounceNisit() { announce,subject,isStatusApi in
            if isStatusApi,
               let annouce = announce,
               let subject = subject{
                let newEntity: [NewsEntity] = annouce.compactMap { item in
                    NewsEntity(id: item.id ?? "",
                                   image: rsaUser.decryptData(text: item.image ?? ""),
                                   name: rsaUser.decryptData(text: item.name ?? ""),
                                   startDate:  DateFormat().stringToDate(isoDate: item.startdate),
                                   endDate:  DateFormat().stringToDate(isoDate: item.enddate))
                }
                
                let subjectEntity: [SubjectEntity] = subject.compactMap { item in
                    SubjectEntity(id: rsaUser.decryptData(text: item.id ?? ""),
                                  name: rsaUser.decryptData(text: item.name ?? ""),
                                  room: rsaUser.decryptData(text: item.room ?? ""),
                                  date: Day(rawValue: item.date ?? "") ?? .mon,
                                  lecturer: rsaUser.decryptData(text: item.lecturer ?? ""),
                                  endTime: item.endTime ?? "",
                                  startTime: item.startTime ?? "",
                                  sec: rsaUser.decryptData(text: item.sec ?? ""))
                }
                
                completion(AnnounceNisitEntity(new: newEntity, subject: subjectEntity),isStatusApi)
            } else {
                completion(nil,isStatusApi)
            }
        }
    }
    
    func fetchAnnounceAdminList(completion: @escaping (AnnounceAdminEntity?, Bool) -> Void) {
        remoteDataSource.fetchAnnounceAdmin() { announce,activity,isStatusApi in
            if isStatusApi,
               let annouce = announce,
               let activity = activity {
                let newEntity: [NewsEntity] = annouce.compactMap { item in
                    NewsEntity(id: item.id ?? "",
                                   image: rsaUser.decryptData(text: item.image ?? ""),
                                   name: rsaUser.decryptData(text: item.name ?? ""),
                                   startDate:  DateFormat().stringToDate(isoDate: item.startdate),
                                   endDate:  DateFormat().stringToDate(isoDate: item.enddate))
                }
//                // debugPrint()
                
                let activityEntity: [ActivityEntity] = activity.compactMap { item in
                    
                    ActivityEntity(id: item.id ?? "",
                                   name: rsaUser.decryptData(text: item.name ?? ""),
                                   date: DateFormat().stringToDate(isoDate: item.date) ,
                                   description: rsaUser.decryptData(text: item.description ?? ""),
                                   location: rsaUser.decryptData(text: item.location ?? ""),
                                   startDate: DateFormat().stringToDate(isoDate: item.startdate) ,
                                   endDate: DateFormat().stringToDate(isoDate: item.enddate))
                }
                
                completion(AnnounceAdminEntity(new: newEntity, activity: activityEntity),isStatusApi)
            } else {
                completion(nil,isStatusApi)
            }
        }
    }
}
