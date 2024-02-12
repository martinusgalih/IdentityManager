//
//  FetchIdentityUseCase.swift
//  IdentityManager
//
//  Created by Martinus Galih Widananto on 12/02/24.
//

import Foundation

protocol FetchIdentityUseCase {
    func fetch(
        cached: @escaping (IdentityPage) -> Void,
        completion: @escaping (Result<IdentityPage, Error>) -> Void
    ) -> Cancellable?
}

class DefaultFetchIdentityUseCase: FetchIdentityUseCase {
    private let identityRepository: IdentityRepository

    init(identityRepository: IdentityRepository) {
        self.identityRepository = identityRepository
    }

    func fetch(
        cached: @escaping (IdentityPage) -> Void,
        completion: @escaping (Result<IdentityPage, Error>) -> Void
    ) -> Cancellable? {
        return identityRepository.fetchIdentityRepository(cached: cached, completion: completion)
    }
}
