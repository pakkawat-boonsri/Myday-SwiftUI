//
//  TaskDatasouce.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 5/10/2565 BE.
//

import Foundation
import Alamofire

class AllTaskDatasouce {
    
    func fetchData(date: Day, dateTime: Date, completion: @escaping (_ activity: [Activity]?, _ subject: [Subject]? , _ isStatusApi: Bool) -> Void) {
        
        if let token = userInfo?.token {
            let url: String = apiUrl + "task/filter/all/" + token + "&" + "\(date.rawValue)" + "&" + DateFormat().dateToStringShot(date: dateTime)
            // debugPrint("url = ", url)
            AF.request(url).responseDecodable(of: filterAllRemoteModel.self) { response in
                      switch (response.result){
                      case .success:
                          debugPrint("urlAll :", url)
                          debugPrint(response.value?.result?.activity?.description)
                          if let all = response.value?.result {
                              completion(all.activity,all.subject, true)
                          } else {
                              completion(nil, nil, false)
                          }
                        break
                      case .failure:
                        // debugPrint("fetchAll Error \(response.result)")
                        break
                      }
                    }
        }

    }
}



struct filterAllRemoteModel: Codable  {
    var status: Int?
    var result: filterAllResult?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case result = "result"
    }
}

struct filterAllResult: Codable  {
    var subject: [Subject]?
    var activity: [Activity]?
    
    enum CodingKeys: String, CodingKey {
        case subject = "subject"
        case activity = "activity"
    }
}
