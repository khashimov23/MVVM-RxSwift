//
//  viewModel.swift
//  MVVM-RxSwift
//
//  Created by Shavkat Khoshimov on 15/10/22.
//

import UIKit
import RxSwift
import RxCocoa
import Moya

class FirstViewModel {
    
    private let service: MoyaProvider<MoyaService>
    private var bag = DisposeBag()

    var posts = BehaviorSubject(value: [Post]())
    
    init(service: MoyaProvider<MoyaService> = MoyaProvider<MoyaService>()) {
        self.service = service
    }
    
    
    func fetchPosts() {
        service.rx.request(.getPosts()).subscribe { [weak self] (event) in
            switch event {
                case .success(let response):
                    do {
                        let filterResponse = try response.filterSuccessfulStatusCodes()
                        
                        let posts = try filterResponse.map([Post].self, using: JSONDecoder())
                        self?.posts.onNext(posts)
                    
                        print(try response.mapJSON())
                    } catch let error {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }.disposed(by: bag)
    }
    
    
    func addPost(post: Post) {
        guard var posts = try? posts.value() else { return }
        posts.insert(post, at: 0)
        self.posts.on(.next(posts))
    }
    
    func deletePost(index: Int) {
        guard var posts = try? posts.value() else { return }
        posts.remove(at: index)
        self.posts.on(.next(posts))
    }
    
    func editPost(title: String, index: Int) {
        guard var posts = try? posts.value() else { return }
        posts[index].title = title
        self.posts.on(.next(posts))
    }
}
