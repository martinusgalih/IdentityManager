//
//  ConnectionError.swift
//  IdentityManager
//
//  Created by Martinus Galih Widananto on 09/02/24.
//

import Foundation

protocol ConnectionError: Error {
    var isInternetConnectionError: Bool { get }
}

extension Error {
    var isInternetConnectionError: Bool {
        guard let error = self as? ConnectionError, error.isInternetConnectionError else {
            return false
        }
        return true
    }
}

