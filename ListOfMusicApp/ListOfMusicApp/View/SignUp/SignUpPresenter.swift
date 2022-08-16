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
    let database: DatabaseProtocol
    
    init(view: SignUpViewProtocol, auth: AuthProtocol, database: DatabaseProtocol) {
        self.view = view
        self.auth = auth
        self.database = database
    }
    
    func tapSignUpButton() {
        auth.signUp(email: view.email, password: view.password).then { [weak self] _ in
            guard let firstName = self?.view.firstName,
                  let lastName = self?.view.lastName,
                  let phoneNumber = self?.view.phoneNumber,
                  let age = self?.view.age,
                  let email = self?.view.email,
                  let password = self?.view.password
            else { return }
            self?.view.showSuccessDialog()
            guard let user = self?.database.add(UserData.self) else { return }
            user.firstName = firstName
            user.lastName = lastName
            user.phoneNumber = phoneNumber
            user.age = age
            user.email = email
            user.password = password
            self?.database.save()
        }.catch { error in
            self.view.showSignUpError(message: error.localizedDescription)
        }
    }
}
