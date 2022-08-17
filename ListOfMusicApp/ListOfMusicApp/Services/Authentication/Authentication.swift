//
//  Authentication.swift
//  ListOfMusicApp
//
//  Created by Anna Buzhinskaya on 13.08.2022.
//

import Foundation
import FirebaseAuth
import Promises

class Authentication: AuthProtocol {
    func isLogin() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    func signIn(email: String, password: String) -> Promise<UserAuth> {
        return Promise<UserAuth>(on: .main) { fulfill, reject in
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let user = result?.user {
                    fulfill(UserAuth(user))
                } else {
                    reject(error!)
                }
            }
        }
    }
    
    func signUp(email: String, password: String) -> Promise<UserAuth> {
        return Promise<UserAuth>(on: .main) { fultfill, reject in
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let user = result?.user {
                    fultfill(UserAuth(user))
                } else {
                    reject(error!)
                }
            }
            
        }
    }
    
    func logout() -> Bool {
        do {
            try Auth.auth().signOut()
        } catch {
            return false
        }
        return true
    }
}

