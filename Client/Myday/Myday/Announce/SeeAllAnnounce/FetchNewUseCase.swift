//
//  FetchNewUseCase.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 3/10/2565 BE.
//

import Foundation

class FetchNewUseCase {
    let repository: SeeAllAnnounceRepository

    init(repository: SeeAllAnnounceRepository) {
        self.repository = repository
    }

    func execute(completion: @escaping (_ data: [NewsEntity]?, _ isStatusApi: Bool) -> Void) {
        repository.fetchNewList() { (result,isStatusApi)  in
            completion(result,isStatusApi)
        }
    }
    
}
