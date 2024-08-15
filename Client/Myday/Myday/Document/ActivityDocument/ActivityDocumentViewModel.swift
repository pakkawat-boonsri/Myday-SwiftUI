//
//  ActivityDocumentViewModel.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 21/9/2565 BE.
//

import Foundation
import Combine
import Alamofire

enum TypeActivityDocument {
    case edit
    case create
    case delete
}

class ActivityDocumentViewModel : ObservableObject {
    
    @Published var id: String?
    @Published var name: String = ""
    @Published var location: String = ""
    @Published var description: String = ""
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    @Published var massageComple: String = ""
    @Published var massageError: String = ""
    
    @Published var typeDocument: TypeActivityDocument = .create
    
    private var cancelBag = Set<AnyCancellable>()
    
    init() {
        Blinding()
    }
    
    func setMassage(type: TypeActivityDocument){
        switch(type){
            
        case .edit:
            massageComple = NSLocalizedString("edit_success", comment: "")
            massageError = NSLocalizedString("edit_error", comment: "")
            break
            
        case .create:
            massageComple = NSLocalizedString("create_success", comment: "")
            massageError = NSLocalizedString("create_error", comment: "")
            break
            
        case .delete:
            massageComple = NSLocalizedString("delete_success", comment: "")
            massageError = NSLocalizedString("delete_error", comment: "")
            break
        }
    }
    
    func setUp(typeDocument: TypeActivityDocument){
        self.typeDocument = typeDocument
    }
    
    func Blinding() {
        
        $startDate
            .receive(on: RunLoop.main)
            .sink { value in
                if value > self.endDate {
                    self.endDate = value
                }
                debugPrint("$startDate value = \(value)")
            }
            .store(in: &cancelBag)
        
        $endDate
            .receive(on: RunLoop.main)
            .sink { value in
                debugPrint("$endDate value = \(value)")
            }
            .store(in: &cancelBag)
        
    }
    
    func deleteActivityAPIData(completion: @escaping (_ stasus: Bool) -> Void) {
        
        self.setMassage(type: .delete)
        
        if let _id: String = self.id, let token = userInfo?.token {
            
            AF.request(apiUrl + "activity/delete/\(token)/" + _id , method: .delete, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseData { response in
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
    }
    
    func updateActivityAPIData(completion: @escaping (_ stasus: Bool) -> Void) {
        
        self.setMassage(type: .edit)
        
        if let _id: String = self.id,let token = userInfo?.token {
            
            let parameters:[String : Any] = [
                "_id": _id,
                "name": rsaDB.encryptData(text: self.name),
                "description": rsaDB.encryptData(text: self.description) ,
                "location": rsaDB.encryptData(text: self.location) ,
                "date": DateFormat().longDateToString(date: Date()),
                "startdate": DateFormat().longDateToString(date: self.startDate),
                "enddate": DateFormat().longDateToString(date: self.endDate),
            ]
            
            debugPrint("parameters: ",parameters)
            
            AF.request(apiUrl + "activity/update/\(token)/" + _id , method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseData { response in
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
    }
    
    func addActivityAPIData(completion: @escaping (_ stasus: Bool) -> Void) {
        
        self.setMassage(type: .create)
        
        if let token: String = userInfo?.token {
            _ = token
            let parameters:[String : Any] = [
                "name": rsaDB.encryptData(text: self.name),
                "description": rsaDB.encryptData(text: self.description),
                "location": rsaDB.encryptData(text: self.location),
                "date": DateFormat().longDateToString(date: Date()),
                "startdate": DateFormat().longDateToString(date: self.startDate),
                "enddate": DateFormat().longDateToString(date: self.endDate),
            ]
 
            
            AF.request(apiUrl + "activity/create/\(token)", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseData { response in
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
    }
}
