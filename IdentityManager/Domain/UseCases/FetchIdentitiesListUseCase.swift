//
//  FetchIdentitiesListUseCase.swift
//  IdentityManager
//
//  Created by Martinus Galih Widananto on 12/02/24.
//

import Foundation

protocol FetchIdentitiesListUseCase {
    func fetch(
        cached: @escaping (IdentityPage) -> Void,
        completion: @escaping (Result<IdentityPage, Error>) -> Void
    ) -> Cancellable?
}

class DefaultFetchIdentitiesListUseCase: FetchIdentitiesListUseCase {
    private let identitiesRepository: IdentitiesRepository

    init(identitiesRepository: IdentitiesRepository) {
        self.identitiesRepository = identitiesRepository
    }

    func fetch(
        cached: @escaping (IdentityPage) -> Void,
        completion: @escaping (Result<IdentityPage, Error>) -> Void
    ) -> Cancellable? {
        return identitiesRepository.fetchIdentitiesRepositoryList(cached: cached, completion: completion)
    }
}
