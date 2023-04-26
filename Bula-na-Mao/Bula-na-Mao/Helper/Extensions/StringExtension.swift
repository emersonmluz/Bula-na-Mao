//
//  StringExtension.swift
//  Bula-na-Mao
//
//  Created by Émerson M Luz on 26/04/23.
//

import Foundation

extension String {
   var containsSpecialCharacter: Bool {
      let regex = ".*[^A-Za-z0-9].*"
      let testString = NSPredicate(format:"SELF MATCHES %@", regex)
      return testString.evaluate(with: self)
   }
    
    var containsNumber: Bool {
        let regex = ".*[0-9]+.*"
        let testString = NSPredicate(format:"SELF MATCHES %@", regex)
        return testString.evaluate(with: self)
    }
    
    var containsAlphaNumeric: Bool {
       let regex = ".*[A-Za-z0-9].* [A-Za-z0-9].*"
       let testString = NSPredicate(format:"SELF MATCHES %@", regex)
       return testString.evaluate(with: self)
    }
    
    var emailValidate: Bool {
            let regex = "[a-z0-9]*+@[a-z0-9]*+\(".")[a-z]*+\(".")?[a-z]*?"
            let testString = NSPredicate(format:"SELF MATCHES %@", regex)
            return testString.evaluate(with: self)
        }
}
