//
//  IdentityRepository.swift
//  IdentityManager
//
//  Created by Martinus Galih Widananto on 12/02/24.
//

import Foundation

protocol IdentityRepository {
    @discardableResult
    func fetchIdentityRepository(
        cached: @escaping (IdentityPage) -> Void,
        completion: @escaping (Result<IdentityPage, Error>) -> Void
    ) -> Cancellable?
}
