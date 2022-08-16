//
//  String+Extension.swift
//  ListOfMusicApp
//
//  Created by Anna Buzhinskaya on 12.08.2022.
//

import Foundation

extension String {
    enum ValidTypes {
        case name
        case email
        case password
        case phone
    }
    
    enum Regex: String {
        case name = "[a-zA-Z]{1,}"
        case email = "[a-zA-Z0-9._-]+@[a-zA-Z0-9]+\\.[a-zA-Z]{2,}"
        case password = "(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{6,}"
        case phone = "^\\+?7.*[0-9]{3}.*[0-9]{3}.*[0-9]{2}.*[0-9]{2}$"
    }
    
    func isValid(type: ValidTypes) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch type {
        case .name:
            regex = Regex.name.rawValue
        case .email:
            regex = Regex.email.rawValue
        case .password:
            regex = Regex.password.rawValue
        case .phone:
            regex = Regex.phone.rawValue
        }
        
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
}
