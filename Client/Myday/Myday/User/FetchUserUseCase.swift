//
//  FetchUserUseCase.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 22/9/2565 BE.
//

import Foundation
import Alamofire

class FetchUserUseCase {
    
    func execute(token: String,completion: @escaping (_ data: UserInfoEntity?, _ isStatusApi: Bool) -> Void) {
//        let url: String = apiUrl + "user/xGiwRbTozPZzoYQdvLr3Vgaae3V2" // user
//        let url: String = apiUrl + "user/BHEL3mMiNANqfwnYtkNoEGrUi1D3" // admin
//        let url: String = apiUrl + "user/BHEL3mMiNANqfwnYtkNoE" // error
        let url: String = apiUrl + "user/" + token
        
        debugPrint("url = \(url)")
        self.fetchUser(url: url) { (result,isStatus) in
            
            if let userData = result {
                    
                let user = UserInfoEntity(id: userData.id ?? "" ,
                                              token: userData.token ?? "",
                                              name: userData.name ?? "",
                                              lname: userData.lname ?? "",
                                              role: Role(rawValue: (userData.role ?? 101)!) ?? .nisit)
                completion(user, true)
            } else {
                completion(nil, false)
            }
        }
    }
    
    func fetchUser(url: String,completion: @escaping (_ data: UserInfo?, _ isStatusApi: Bool) -> Void) {
        AF.request(url).responseDecodable(of: UserRemoteModel.self) { response in
                  switch (response.result){
                  case .success:
                      if let data = response.value?.result {
                          completion(data, true)
                      } else {
                          completion(nil, false)
                      }
                    break
                  case .failure:
                    break
                  }
                }
    }
    
}
