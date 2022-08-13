//
//  SignInViewProtocol.swift
//  ListOfMusicApp
//
//  Created by Anna Buzhinskaya on 13.08.2022.
//

import Foundation

enum SignInViewNavigation {
    case music
}

protocol SignInViewProtocol {
    var email: String { get set }
    var password: String { get set }
    
    func move(to: SignInViewNavigation)
    func showSignInError(message: String)
}
