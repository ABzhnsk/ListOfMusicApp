//
//  User.swift
//  ListOfMusicApp
//
//  Created by Anna Buzhinskaya on 12.08.2022.
//

import Foundation
import FirebaseAuth

struct User {
    let email: String
}

extension User {
    init(_ user: FirebaseAuth.User) {
        email = user.email ?? ""
    }
}
