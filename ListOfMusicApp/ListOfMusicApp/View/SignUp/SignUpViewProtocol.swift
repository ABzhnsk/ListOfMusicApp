//
//  SignUpViewProtocol.swift
//  ListOfMusicApp
//
//  Created by Anna Buzhinskaya on 14.08.2022.
//

import Foundation

protocol SignUpViewProtocol {
    var firstName: String { get set }
    var lastName: String { get set }
    var phoneNumber: String { get set }
    var age: Date { get }
    var email: String {get set}
    var password: String {get set}
    
    func showSuccessDialog()
    func showSignUpError(message: String)
}
