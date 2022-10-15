//
//  SecondViewModel.swift
//  MVVM-RxSwift
//
//  Created by Shavkat Khoshimov on 15/10/22.
//

import UIKit
import RxSwift
import RxCocoa
import Moya
import RxDataSources

class SecondViewModel {
    
    private let service: MoyaProvider<MoyaService>
    private var bag = DisposeBag()

    var posts = BehaviorSubject(value: [SectionModel(model: "", items: [Post]())])
    
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
                        
                        let firstSection = SectionModel(model: "First", items: [Post(userID: 0, id: 1, title: "Swift", body: "Cool language")])
                        
                        let secondSection = SectionModel(model: "Second", items: posts)
                        
                        self?.posts.on(.next([firstSection, secondSection]))
                        
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
        guard var sections = try? posts.value() else { return }
        var currentSection = sections[0]
        currentSection.items.insert(post, at: 0)
        sections[0] = currentSection
        self.posts.onNext(sections)
    }
    
    func deletePost(indexPath: IndexPath) {
        guard var sections = try? posts.value() else { return }
        var currentSection = sections[indexPath.section]
        currentSection.items.remove(at: indexPath.row)
        sections[indexPath.section] = currentSection
        self.posts.onNext(sections)
    }
    
    func editPost(title: String, indexPath: IndexPath) {
        guard var sections = try? posts.value() else { return }
        var currentSection = sections[indexPath.section]
        currentSection.items[indexPath.row].title = title
        sections[indexPath.section] = currentSection
        self.posts.onNext(sections)
    }
}
