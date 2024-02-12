//
//  LoginRepository.swift
//  IdentityManager
//
//  Created by Martinus Galih Widananto on 12/02/24.
//

import Foundation

protocol LoginRepository {
    @discardableResult
    func fetchLogin(username: String,
                    password: String,
                    completion: @escaping (Result<LoginPage, Error>) -> Void
    ) -> Cancellable?
}
