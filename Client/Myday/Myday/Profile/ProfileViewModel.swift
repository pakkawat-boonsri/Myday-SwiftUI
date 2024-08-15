//
//  ProfileViewModel.swift
//  Myday
//
//  Created by วิศวะ โชติพันธุ์พงศ์ on 17/9/2565 BE.
//

import Foundation
import FirebaseAuth

class ProfileViewModel : ObservableObject {
    
    
    let user = FirebaseAuth.Auth.auth().currentUser?.email ?? "test@ku.th"
        
    init(){
        
    }
    
    func signOut(completion: @escaping (_ status: Bool) -> Void) {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            debugPrint(signOutError)
            completion(false)
        }
        completion(true)
    }
}
