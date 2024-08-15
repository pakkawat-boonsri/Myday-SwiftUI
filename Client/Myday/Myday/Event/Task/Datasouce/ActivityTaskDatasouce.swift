//
//  ActivityTaskDatasouce.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 5/10/2565 BE.
//

import Foundation
import Alamofire

class ActivityTaskDatasouce {
    
    func fetchData(dateTime: Date,completion: @escaping (_ activit: [Activity]? , _ isStatusApi: Bool) -> Void) {
        if let token = userInfo?.token {
            let url: String = apiUrl + "task/filter/activity/" + token + "&" + DateFormat().dateToStringShot(date: dateTime)
            debugPrint("URL: ",url)
            AF.request(url).responseDecodable(of: filterActivityRemoteModel.self) { response in
                      switch (response.result){
                      case .success:
                          if let activity = response.value?.result {
                              completion(activity, true)
                          } else {
                              completion(nil, false)
                          }
                        break
                      case .failure:
                         debugPrint("fetchActivity Error \(response.result)")
                        break
                      }
                    }
        }
    }
}

struct filterActivityRemoteModel: Codable  {
    var status: Int?
    var result: [Activity]?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case result = "result"
    }
}
