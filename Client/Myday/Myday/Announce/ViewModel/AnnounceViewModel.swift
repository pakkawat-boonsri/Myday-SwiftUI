//
//  AnnounceViewModel.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 21/9/2565 BE.
//

import Foundation
import Alamofire
import SwiftUI

class AnnounceViewModel: ObservableObject {
    
    var fetchAnnounceUseCase: FetchAnnounceUseCase
    
    @Published var new: [NewsEntity] = [MockNew]
    @Published var subject: [SubjectEntity] = MockSubject
    @Published var activity: [ActivityEntity] = MockActivity
    @Published var statusApi: Bool = false
    
    
    init(role: Role) {

        fetchAnnounceUseCase = FetchAnnounceUseCase(repository: AnnounceRepository(dataSource: AnnounceDataSource()))
        fetchData(role: role) { status in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.statusApi = status
            }
        }
    }
    
    
    func fetchData(role: Role,comple: @escaping (_ status: Bool) -> Void){
        

        self.statusApi = false
        
        switch(role){
        case .nisit:
            fetchAnnounceUseCase.executeNisit() { (result,isStatusApi) in
                // debugPrint("executeNisit Api = \(isStatusApi)")
                if let data = result {
                    self.new = data.new
                    self.subject = data.subject
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        comple(isStatusApi)
                    }
                }
            }
            break
        case .lecturer:
            break
        case .admin:
            fetchAnnounceUseCase.executeAdmin() { (result,isStatusApi) in
                // debugPrint("executeAdmin Api = \(isStatusApi)")
                if let data = result {
                    self.new = data.new
                    self.activity = data.activity
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        comple(isStatusApi)
                    }
                }
            }
            break
        }
    }

}




