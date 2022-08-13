//
//  SignInPresenter.swift
//  ListOfMusicApp
//
//  Created by Anna Buzhinskaya on 13.08.2022.
//

import Foundation

class SignInPresenter {
    var view: SignInViewProtocol
    let auth: AuthProtocol
    
    init(view: SignInViewProtocol, auth: AuthProtocol) {
        self.view = view
        self.auth = auth
    }
    
    func show() {
        if auth.isLogin() {
            view.move(to: .music)
        }
    }
    
    func tapSignInButton() {
        auth.signIn(email: view.email, password: view.password).then { _ in
            self.view.email = ""
            self.view.password = ""
            self.view.move(to: .music)
        }.catch { error in
            self.view.showSignInError(message: error.localizedDescription)
        }
    }
}
