//
//  Validations.swift
//  Bula-na-Mao
//
//  Created by Émerson M Luz on 26/04/23.
//

import Foundation

class Validations {
    static var shared = Validations()
    
    func validateFullName(fullName: String) -> Bool {
        if fullName.containsAlphaNumeric {
            return true
        }
        return false
    }
    
    func validateEmail(email: String) -> Bool {
        if (email.emailValidate || email.containsSpecialCharacter) && !(email.contains(" ")) {
                return true
            }
        return false
    }
    
    func validatePassword(password: String) -> Bool {
        if password.count >= 6 && password.containsSpecialCharacter && password.containsNumber {
            return true
        }
        return false
    }
    
    func validateConfirmPassword(password: String, confirmPassword: String) -> Bool {
        if password == confirmPassword {
            return true
        }
        return false
    }
}


