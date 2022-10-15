//
//  User.swift
//  MVVM-RxSwift
//
//  Created by Shavkat Khoshimov on 15/10/22.
//

import Foundation


struct Post: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}


//// MARK: - UserElement
//struct User: Codable {
//    let id: Int
//    let name, username, email: String
//    let address: Address
//    let phone, website: String
//    let company: Company
//}
//
//// MARK: - Address
//struct Address: Codable {
//    let street, suite, city, zipcode: String
//    let geo: Geo
//}
//
//// MARK: - Geo
//struct Geo: Codable {
//    let lat, lng: String
//}
//
//// MARK: - Company
//struct Company: Codable {
//    let name, catchPhrase, bs: String
//}
//
