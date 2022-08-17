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
    func logout() -> Bool
    func signIn(email: String, password: String) -> Promise<UserAuth>
    func signUp(email: String, password: String) -> Promise<UserAuth>
}
