//
//  User.swift
//  MVVM-RxSwift
//
//  Created by Shavkat Khoshimov on 15/10/22.
//

import Foundation

struct Post: Codable {
    let userID, id: Int
    var title: String
    let body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
