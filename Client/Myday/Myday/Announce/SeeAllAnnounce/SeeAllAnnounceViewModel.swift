//
//  SeeAllAnnounceViewModel.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 3/10/2565 BE.
//

import Foundation


class SeeAllAnnounceViewModel: ObservableObject{
    
    var fetchNewUseCase: FetchNewUseCase
    
    @Published var new: [NewsEntity] = MockNewSeeAll
    @Published var isStatusApi: Bool = false
    
    init(){
        fetchNewUseCase = FetchNewUseCase(repository: SeeAllAnnounceRepository(dataSource: AnnounceDataSource()))
        loadData() { status in
            self.isStatusApi = status
        }
    }
    
    func loadData(completion: @escaping (_ status: Bool) -> Void) {
        fetchNewUseCase.execute() { result, isStatusApi in
            if let data = result {
                self.new = data
            }
           completion(isStatusApi)
        }
    }
    
}
