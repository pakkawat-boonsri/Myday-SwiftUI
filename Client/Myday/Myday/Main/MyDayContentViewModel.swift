//
//  MyDayContentViewModel.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 22/9/2565 BE.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
import Alamofire

var user: User?
var userInfo: UserInfoEntity?
var apiUrl: String = ""
let firebase: String = "https://myday-project-default-rtdb.asia-southeast1.firebasedatabase.app"

let rsaUser = RSA()
let rsaDB = RSA()

struct PublicKeyRemoteModel: Codable {
    var n: Int?
    var e: Int?
    
    enum CodingKeys: String, CodingKey {
        case n = "N"
        case e = "E"
    }
}


class MyDayContentViewModel: ObservableObject {
    
    var fetchUserUseCase: FetchUserUseCase
    @Published var status: Bool = false
    
    init(){
        self.fetchUserUseCase = FetchUserUseCase()
        self.ex()
    }
    func ex() {
        if let uid = Auth.auth().currentUser?.uid,
           let email = Auth.auth().currentUser?.email {
            user = User(token: uid, email: email)
            self.getApiUrl() { url in
                apiUrl = url
                
                self.fetchUserUseCase.execute(token: uid) { data,isStatus in
                    // debugPrint("///////////////////////////////////////////////")
                    // debugPrint("User = ",data ?? "")
                    // debugPrint("///////////////////////////////////////////////")
                    if let item = data {
                        userInfo = item
                        self.setKey(token: item.token) { status in
                            if status {
                                self.fetchKeyDB() { status in
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                                        self.status = status
                                    }
                                }
                            }
                        }
                    }
                    self.status = isStatus
                }
                
            }
        } else {
            user = nil
        }

    }
    
    func fetchKeyDB(completion: @escaping (Bool) -> Void) {
        if let token = userInfo?.token {
            let url: String = apiUrl + "user/getkey/" + token
            AF.request(url).responseDecodable(of: PublicKeyRemoteModel.self) { response in
                      switch (response.result){
                      case .success:
                          if let data = response.value {
                              debugPrint("BD Key: (N: \(String(describing: data.n)),E: \(String(describing: data.e))")
                              rsaDB.setPublicKey(n: data.n!, e: data.e!)
                              completion(true)
                          } else {
                              completion(false)
                          }
                        break
                      case .failure:
                        // debugPrint("fetchAnnounce Error \(response.result)")
                        break
                      }
                    }
        }
    }
    
    func setKey(token: String,completion: @escaping (Bool) -> Void) {
        rsaUser.genKey()
        let pbKey = rsaUser.getPublicKey()
        
        AF.request(apiUrl + "user/updatekey/" + token + "/\(pbKey.n)&\(pbKey.e)", method: .patch, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseData { response in
            switch(response.result){
            case .success(_):
                completion(true)
                break
            case .failure(_):
                completion(false)
                // debugPrint(response)
                break
            }
        }
    }
    
    
    func getApiUrl(comple: @escaping (String) -> Void) {
        
        let ref: DatabaseReference = Database.database(url: firebase).reference().child("URL")
        
        ref.getData(completion:  { error, snapshot in
            guard error == nil else {
              debugPrint(error!.localizedDescription)
              return;
            }
            if let url = snapshot?.value {
                comple("\(url)")
            }
          });
    }
    
}
