//
//  DispatchQueueType.swift
//  IdentityManager
//
//  Created by Martinus Galih Widananto on 09/02/24.
//

import Foundation

/// Used to easily mock main and background queues in tests
protocol DispatchQueueType {
    func async(execute work: @escaping () -> Void)
}

extension DispatchQueue: DispatchQueueType {
    func async(execute work: @escaping () -> Void) {
        async(group: nil, execute: work)
    }
}
