//
//  LoginRequestQuery.swift
//  IdentityManager
//
//  Created by Martinus Galih Widananto on 10/02/24.
//

import Foundation

struct LoginRequestQuery: Encodable {
    let username: String
    let password: String
}
