//
//  ClassTaskDatasouce.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 5/10/2565 BE.
//

import Foundation
import Alamofire

class ClassTaskDatasouce {
    
    func fetchData(date: Day,completion: @escaping (_ subject: [Subject]? , _ isStatusApi: Bool) -> Void) {
        if let token = userInfo?.token {
            let url: String = apiUrl + "task/filter/class/" + token + "&" + "\(date.rawValue)"
            AF.request(url).responseDecodable(of: filterClassRemoteModel.self) { response in
                      switch (response.result){
                      case .success:
                          if let subject = response.value?.result {
                              completion(subject.subject, true)
                          } else {
                              completion(nil, false)
                          }
                        break
                      case .failure:
                        // debugPrint("fetchSubject Error \(response.result)")
                        break
                      }
                    }
        }
    }
    
}

struct filterClassRemoteModel: Codable  {
    var status: Int?
    var result: filterClassResult?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case result = "result"
    }
}

struct filterClassResult: Codable  {
    var subject: [Subject]?
    
    enum CodingKeys: String, CodingKey {
        case subject = "subject"
    }
}
