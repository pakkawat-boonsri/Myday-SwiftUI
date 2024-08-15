//
//  FetchAnnounceUesCase.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 21/9/2565 BE.
//

import Foundation


class FetchAnnounceUseCase {
    let repository: AnnounceRepositoryProtocol
    
    init(repository: AnnounceRepositoryProtocol) {
        self.repository = repository
    }
    
    func executeNisit(completion: @escaping (_ data: AnnounceNisitEntity?, _ isStatusApi: Bool) -> Void) {
        repository.fetchAnnounceNisitList() { (result,isStatusApi)  in
            completion(result,isStatusApi)
        }
    }
    
    func executeAdmin(completion: @escaping (_ data: AnnounceAdminEntity?, _ isStatusApi: Bool) -> Void) {
        repository.fetchAnnounceAdminList() { (result,isStatusApi)  in
            completion(result,isStatusApi)
        }
    }
    
}
