//
//  LoginRepository.swift
//  IdentityManager
//
//  Created by Martinus Galih Widananto on 12/02/24.
//

import Foundation

protocol LoginRepository {
    @discardableResult
    func fetchLogin(
        completion: @escaping (Result<LoginPage, Error>) -> Void
    ) -> Cancellable?
}
