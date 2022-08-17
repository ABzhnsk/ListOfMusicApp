//
//  SignUpPresenter.swift
//  ListOfMusicApp
//
//  Created by Anna Buzhinskaya on 14.08.2022.
//

import Foundation

class SignUpPresenter {
    var view: SignUpViewProtocol
    let auth: AuthProtocol
    let store = DataStoreManager()
    
    init(view: SignUpViewProtocol, auth: AuthProtocol) {
        self.view = view
        self.auth = auth
    }
    
    func tapSignUpButton() {
        guard let userEmail = view.user.email,
              let userPassword = view.user.password
        else { return }
        
        auth.signUp(email: userEmail, password: userPassword).then { [weak self] _ in
            guard let user = self?.view.user
            else { return }
            self?.view.showSuccessDialog()
            self?.store.saveUser(user)
        }.catch { error in
            self.view.showSignUpError(message: error.localizedDescription)
        }
    }
}
