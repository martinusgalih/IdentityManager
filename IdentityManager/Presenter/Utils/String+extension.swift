//
//  String+extension.swift
//  IdentityManager
//
//  Created by Martinus Galih Widananto on 13/02/24.
//

import Foundation

extension String {
    static let emptyString = ""
    
    func isValidEmail() -> Bool {
        let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        let emailPredicate = NSPredicate(format:"SELF MATCHES[c] %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    func isValidPassword() -> (Bool) {
        // at least 1 uppercase letter
        let uppercaseLetterRegex = ".*[A-Z]+.*"
        guard NSPredicate(format: "SELF MATCHES %@", uppercaseLetterRegex).evaluate(with: self) else { return false }
        
        // at least 1 lowercase letter
        let lowercaseLetterRegex = ".*[a-z]+.*"
        guard NSPredicate(format: "SELF MATCHES %@", lowercaseLetterRegex).evaluate(with: self) else { return false }
        
        // at least 1 number
        let numberRegex = ".*[0-9]+.*"
        guard NSPredicate(format: "SELF MATCHES %@", numberRegex).evaluate(with: self) else { return false }
        
        // at least 1 symbol
        let symbolRegex = ".*[!@#$%^&*()-_=+\\|[{]};:'\",<.>/?]+.*"
        guard NSPredicate(format: "SELF MATCHES %@", symbolRegex).evaluate(with: self) else { return false }
        
        return true
    }
}
