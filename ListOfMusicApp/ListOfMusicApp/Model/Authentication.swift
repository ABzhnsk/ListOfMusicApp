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
    
    func signIn(email: String, password: String) -> Promise<User> {
        return Promise<User>(on: .main) { fulfill, reject in
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let user = result?.user {
                    fulfill(User(user))
                } else {
                    reject(error!)
                }
            }
        }
    }
    
    func signUp(firstName: String, lastName: String, age: String, phoneNumber: String, email: String, password: String) -> Promise<User> {
        return Promise<User>(on: .main) { fultfill, reject in
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let user = result?.user {
                    //create user in data base
                    
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

