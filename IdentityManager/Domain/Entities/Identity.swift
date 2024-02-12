//
//  Identity.swift
//  IdentityManager
//
//  Created by Martinus Galih Widananto on 12/02/24.
//

import Foundation

struct Identity: Equatable {
    let id: String?
    let nik: String?
    let name: String?
    let phone: String?
    let image: String?
    let phoneNo: String?
}

struct IdentityPage: Equatable {
    let count: Int?
    let rows: [Identity]?
}
