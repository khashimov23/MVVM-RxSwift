//
//  MoyaService.swift
//  MVVM-RxSwift
//
//  Created by Shavkat Khoshimov on 15/10/22.
//

import Foundation
import Moya


enum MoyaService: TargetType {
    
    var baseURL: URL { return URL(string: "https://jsonplaceholder.typicode.com")! }
    
    // number of metods for api call
    case getPosts(page: Int = 1)
    
    case getUser(userID: Int)
    case getAllUsers(page: Int)
    case login(email: String, password: String)
    
    var path: String {
        switch self {
            case .getPosts:
                return "/posts"
                
            case .getUser(userID: let id):
                return "/users/\(id)"
            case .getAllUsers(page: let page):
                return "/users?page=\(page)"
            case .login(_,_):
                return "/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .getPosts, .getUser, .getAllUsers:
                return .get
            case .login:
                return .post
        }
    }

    var task: Moya.Task {
        switch self {
        case .getPosts:
            return .requestPlain
        case .getUser:
            return .requestPlain
        case .getAllUsers(let page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.default)
        case .login(email: let email, password: let password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
        }
    }

    var headers: [String : String]? {
        switch self {
            case .getPosts, .getUser, .getAllUsers, .login:
            return ["Accept": "application/json",
                    "Content-type": "application/json"]
        }
    }

    var sampleData: Data {
        switch self {
            case .getUser, .getAllUsers, .login, .getPosts:
                return "Should be filled".utf8Encoded
        }
    }
}


private extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
