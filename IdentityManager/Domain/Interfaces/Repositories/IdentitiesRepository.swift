//
//  IdentitiesRepository.swift
//  IdentityManager
//
//  Created by Martinus Galih Widananto on 12/02/24.
//

import Foundation

protocol IdentitiesRepository {
    @discardableResult
    func fetchIdentitiesRepositoryList(
        cached: @escaping (IdentityPage) -> Void,
        completion: @escaping (Result<IdentityPage, Error>) -> Void
    ) -> Cancellable?
}
