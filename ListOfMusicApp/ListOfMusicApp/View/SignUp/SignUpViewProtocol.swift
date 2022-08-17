//
//  SignUpViewProtocol.swift
//  ListOfMusicApp
//
//  Created by Anna Buzhinskaya on 14.08.2022.
//

import Foundation

protocol SignUpViewProtocol {
    var user: UserDataModel {get set}
    
    func showSuccessDialog()
    func showSignUpError(message: String)
}
