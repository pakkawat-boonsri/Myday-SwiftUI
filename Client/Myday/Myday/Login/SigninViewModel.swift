//
//  SigninViewModel.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 15/9/2565 BE.
//

import Foundation
import Combine
import FirebaseAuth

class SigninViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isValidEmail: Bool = false
    @Published var isValidPassword: Bool = false
    @Published var isShowValid: Bool = false
    @Published var errormasage: String = ""

    private var cancelBag = Set<AnyCancellable>()
    
    init(){
        $email
            .receive(on: RunLoop.main)
            .sink { value in
//                debugPrint("email = \(value)")
                
                self.isValidEmail = value.isEmpty ? false : true
            }
            .store(in: &cancelBag)
        
        $password
            .receive(on: RunLoop.main)
            .sink { value in
//                debugPrint("password = \(value)")
                self.isValidPassword = value.isEmpty ? false : true
            }
            .store(in: &cancelBag)
    }
    
    
    func signIn(completion: @escaping (_ status: Bool)  -> Void) {
        isShowValid = true
        guard isValidPassword && isValidEmail else { return }

        Auth.auth().signIn(withEmail: email, password: password) { authResult , error in
            if let user = authResult?.user  {
                _ = user
                // debugPrint(user.uid)
                completion(true)
            } else {
                if let ms = error?.localizedDescription {
                    self.errormasage = ms
                }
                completion(false)
            }
        }
}
    
    
    
}
