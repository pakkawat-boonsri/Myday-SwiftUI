//
//  AnnounceDataSource.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 21/9/2565 BE.
//

import Foundation
import Alamofire

class AnnounceDataSource {
    
    func fetchAnnounceNisit(completion: @escaping (_ announce: [Announce]?,_ subject: [Subject]? , _ isStatusApi: Bool) -> Void) {
        if let token = userInfo?.token {
            let url: String = apiUrl + "subject/" + token
            AF.request(url).responseDecodable(of: SubjectRemoteModel.self) { response in
                      switch (response.result){
                      case .success:
                          if let subject = response.value?.result {
                              self.fetchAnnounce { announce,isStatusApi in
                                  if isStatusApi {
                                      completion(announce, subject , true)
                                  } else {
                                      completion(nil, subject , true)
                                  }
                              }
                          } else {
                              completion(nil, nil, false)
                          }
                        break
                      case .failure:
                        // debugPrint("fetchAnnounceNisit Error \(response.result)")
                        break
                      }
                    }
        }
    }
    
    func fetchAnnounceAdmin(completion: @escaping (_ announce: [Announce]?,_ activit: [Activity]? , _ isStatusApi: Bool) -> Void) {
        if let token = userInfo?.token {
            let url: String = apiUrl + "activity/" + token
            AF.request(url).responseDecodable(of: ActivityRemoteModel.self) { response in
                      switch (response.result){
                      case .success:
                          if let activity = response.value?.result {
                              self.fetchAnnounce() { announce,isStatusApi in
                                  if isStatusApi {
                                      completion(announce, activity , true)
                                  } else {
                                      completion(nil, activity , true)
                                  }
                              }
                          } else {
                              completion(nil, nil, false)
                          }
                        break
                      case .failure:
                        // debugPrint("fetchAnnounceAdmin Error \(response.result)")
                        break
                      }
                    }
        }
    }
    
    func fetchAnnounce(completion: @escaping (_ announce: [Announce]? , _ isStatusApi: Bool) -> Void) {
        if let token = userInfo?.token {
            let url: String = apiUrl + "annouce/" + token
            AF.request(url).responseDecodable(of: AnnounceRemoteModel.self) { response in
                      switch (response.result){
                      case .success:
                          if let data = response.value?.result {
                              completion(data, true)
                          } else {
                              completion(nil, false)
                          }
                        break
                      case .failure:
                        // debugPrint("fetchAnnounce Error \(response.result)")
                        break
                      }
                    }
        }
    }
    
}

struct AnnounceRemoteModel: Codable {
    var status: Int?
    var result: [Announce]?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case result = "result"
    }

}

struct Announce: Codable {
    var id: String?
    var image: String?
    var name: String?
    var startdate: String?
    var enddate: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case image = "image"
        case name = "name"
        case startdate = "startdate"
        case enddate = "enddate"
    }
}

struct ActivityRemoteModel: Codable {
    var status: Int?
    var result: [Activity]?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case result = "result"
    }
}

struct Activity: Codable {
    var id: String?
    var name: String?
    var date: String?
    var description: String?
    var location: String?
    var enddate: String?
    var startdate: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name = "name"
        case date = "date"
        case description = "description"
        case location = "location"
        case enddate = "enddate"
        case startdate = "startdate"
    }
}
