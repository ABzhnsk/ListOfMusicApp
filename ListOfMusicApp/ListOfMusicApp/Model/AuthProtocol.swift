//
//  AuthProtocol.swift
//  ListOfMusicApp
//
//  Created by Anna Buzhinskaya on 13.08.2022.
//

import Foundation
import Promises

protocol AuthProtocol {
    func isLogin() -> Bool
    func signIn(email: String, password: String) -> Promise<User>
    func signUp(firstName: String, lastName: String, age: String, phoneNumber: String, email: String, password: String) -> Promise<User>
}
