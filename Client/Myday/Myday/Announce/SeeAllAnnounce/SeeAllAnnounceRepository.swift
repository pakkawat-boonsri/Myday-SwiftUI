//
//  SeeAllAnnounceRepository.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 3/10/2565 BE.
//

import Foundation

class SeeAllAnnounceRepository {
    
    let remoteDataSource: AnnounceDataSource
    
    init(dataSource: AnnounceDataSource) {
        self.remoteDataSource = dataSource
    }
    
    func fetchNewList(completion: @escaping ([NewsEntity]?, Bool) -> Void) {
        remoteDataSource.fetchAnnounce() { announce,isStatusApi in
            if isStatusApi,
               let annouce = announce{
                let newEntity: [NewsEntity] = annouce.compactMap { item in
                    NewsEntity(id: item.id ?? "",
                               image: rsaUser.decryptData(text: item.image ?? "") ,
                                   name: rsaUser.decryptData(text: item.name ?? ""),
                                   startDate:  DateFormat().stringToDate(isoDate: item.startdate) ,
                                   endDate:  DateFormat().stringToDate(isoDate: item.enddate))
                }
                
                completion(newEntity,isStatusApi)
            } else {
                completion(nil,isStatusApi)
            }
        }
    }
    
}
