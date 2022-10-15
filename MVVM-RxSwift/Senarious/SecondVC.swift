//
//  SecondVC.swift
//  MVVM-RxSwift
//
//  Created by Shavkat Khoshimov on 15/10/22.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class SecondVC: UIViewController, UITableViewDelegate {

    private var viewModel = SecondViewModel()
    private var bag = DisposeBag()
    let identifier = "UserTableViewCell"
    
    lazy var tableView: UITableView = {
        let tableV = UITableView(frame: .zero, style: .insetGrouped)
        tableV.backgroundColor = .systemTeal
        tableV.register(PostTableViewCell.self, forCellReuseIdentifier: identifier)
        return tableV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel.fetchPosts()
        bindTableView()
        let add = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(onTapAdd))
        self.navigationItem.rightBarButtonItem = add
    }
    
    @objc func onTapAdd() {
        let post = Post(userID: 1, id: 1, title: "New Post", body: "There is no problem, InshaAlloh")
        self.viewModel.addPost(post: post)
    }

    func bindTableView() {
        tableView.rx.setDelegate(self).disposed(by: bag)
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Post>> { _, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath) as! PostTableViewCell
            cell.textLabel?.text = item.title
            cell.detailTextLabel?.text = "\(item.id)"
            cell.height(80)
            return cell
        } titleForHeaderInSection: { dataSource, sectionIndex in
            return dataSource[sectionIndex].model
        }

        self.viewModel.posts.bind(to: self.tableView.rx.items(dataSource: dataSource)).disposed(by: bag)

        self.tableView.rx.itemDeleted.subscribe { [weak self] indexPath in
            guard let self = self else { return }
            self.viewModel.deletePost(indexPath: indexPath)
        }.disposed(by: bag)
        
        // edit item
        tableView.rx.itemSelected.subscribe { [weak self] (indexPath) in
            guard let self = self else { return }
            let alert = UIAlertController(title: "Note", message: "Edit post", preferredStyle: .alert)
            alert.addTextField { textField in }
            alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { action in
                if let textField = alert.textFields?[0] as? UITextField, let text = textField.text, !text.isEmpty {
                    self.viewModel.editPost(title: textField.text ?? "", indexPath: indexPath)
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                self.dismiss(animated: true)
            }))
            DispatchQueue.main.async {
                self.present(alert, animated: true)
            }
        }.disposed(by: bag)

    }
    
    
    func configureUI() {
        self.view.addSubviews(parent: self.view, subviews: [tableView])
        tableView.left(self.view.leftAnchor)
        tableView.right(self.view.rightAnchor)
        tableView.top(self.view.topAnchor)
        tableView.bottom(self.view.bottomAnchor)
    }
}

