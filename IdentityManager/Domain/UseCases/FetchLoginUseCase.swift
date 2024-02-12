//
//  FetchLoginUseCase.swift
//  IdentityManager
//
//  Created by Martinus Galih Widananto on 12/02/24.
//

import Foundation

protocol FetchLoginUseCase {
    func fetch(username: String,
               password: String,
               completion: @escaping (Result<LoginPage, Error>) -> Void) -> Cancellable?
}

class DefaultFetchLoginUseCase: FetchLoginUseCase {
    private let loginRepository: LoginRepository
    
    init(loginRepository: LoginRepository) {
        self.loginRepository = loginRepository
    }
    
    func fetch(username: String,
               password: String,
               completion: @escaping (Result<LoginPage, Error>) -> Void
    ) -> Cancellable? {
        return loginRepository.fetchLogin(username: username, password: password, completion: completion)
    }
}
