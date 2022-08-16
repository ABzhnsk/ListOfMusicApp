//
//  UserAuth.swift
//  ListOfMusicApp
//
//  Created by Anna Buzhinskaya on 12.08.2022.
//

import Foundation
import FirebaseAuth

struct UserAuth {
    let email: String
}

extension UserAuth {
    init(_ user: FirebaseAuth.User) {
        email = user.email ?? ""
    }
}
