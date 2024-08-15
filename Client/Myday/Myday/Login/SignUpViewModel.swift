//
//  SignUpViewModel.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 17/9/2565 BE.
//

import Foundation
import Combine
import FirebaseAuth
import Alamofire

class SignUpViewModel: ObservableObject {
    @Published var firstname: String = ""
    @Published var surname: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    @Published var isValidFirstName: Bool = false
    @Published var isValidSurname: Bool = false
    
    @Published var isValidEmail: Bool = false
    @Published var isValidPassword: Bool = false
    @Published var isValidConfirmPassword: statusPassword = .empty
    @Published var isShowValid: Bool = false
    
    @Published var isCreate: Bool = false
    
    enum statusPassword {
        case empty
        case different
        case same
    }

    private var cancelBag = Set<AnyCancellable>()
    
    init(){
        $email
            .receive(on: RunLoop.main)
            .sink { value in
                
                self.isValidEmail = value.isEmpty ? false : true
            }
            .store(in: &cancelBag)
        
        $password
            .receive(on: RunLoop.main)
            .sink { value in
                
                self.isValidPassword = value.isEmpty ? false : true
            }
            .store(in: &cancelBag)
        
        $confirmPassword
            .receive(on: RunLoop.main)
            .sink { value in
                switch(value) {
                    
                    case "" :
                        self.isValidConfirmPassword = .empty
                        break
                    
                    case self.password :
                        self.isValidConfirmPassword = .same
                        break
                    
                    default:
                        self.isValidConfirmPassword = .different
                        break
                }
            }
            .store(in: &cancelBag)
        
        $firstname
            .receive(on: RunLoop.main)
            .sink { value in
                
                self.isValidFirstName = value.isEmpty ? false : true
            }
            .store(in: &cancelBag)
        
        $surname
            .receive(on: RunLoop.main)
            .sink { value in
                
                self.isValidSurname = value.isEmpty ? false : true
            }
            .store(in: &cancelBag)
        
//        $isCreate
//            .receive(on: RunLoop.main)
//            .sink { value in
//                if value {
//                    self.createUserInfo() { status in
//                        debugPrint("status =",status)
//                    }
//                }
//            }
//            .store(in: &cancelBag)
    }
    
    func createUserInfo(token: String,completion: @escaping (_ status: Bool) -> Void) {
   
        let parameters: [String : Any] = [
            "token" : token,
            "name" : self.firstname,
            "lname" : self.surname,
            "role" : 101,
            "publickeyN" : 6497,
            "publickeyE" : 5,
            "subject" : MockCreateSubject
        ]
        
        AF.request(apiUrl + "user/adduser", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseData { response in
            switch(response.result){
                
            case .success(_):
                debugPrint("singUp success",response)
                completion(true)
            case .failure(_):
                debugPrint("singUp failure",response)
                completion(false)
            }
        }
    }
    
    
    func signUp(completion: @escaping (_ token: String, _ status: Bool) -> Void) {
        isShowValid = true
        
        guard isValidPassword && isValidEmail else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult , error in
            
            if authResult != nil {
//                 debugPrint(status)
                if let id = authResult?.user.uid {
                    completion(id,true)
                }
            } else if error != nil {
                // debugPrint(errorResult)
                completion("",false)
            }
        }
    }
}

