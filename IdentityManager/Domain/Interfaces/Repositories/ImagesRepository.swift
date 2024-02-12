//
//  ImagesRepository.swift
//  IdentityManager
//
//  Created by Martinus Galih Widananto on 12/02/24.
//

import Foundation

protocol ImagesRepository {
    func fetchImage(
        with imagePath: String,
        size: Int,
        completion: @escaping (Result<Data, Error>) -> Void
    ) -> Cancellable?
}
