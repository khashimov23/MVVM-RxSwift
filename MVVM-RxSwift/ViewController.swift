//
//  ViewController.swift
//  MVVM-RxSwift
//
//  Created by Shavkat Khoshimov on 15/10/22.
//

import UIKit

class ViewController: UIViewController {

    lazy var submitBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("go ahead", for: .normal)
        btn.backgroundColor = .cyan
        btn.addTarget(self, action: #selector(onClickSubmitBtn), for: .touchUpInside)
        return btn
    }()
    
    lazy var itemLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "item label"
        lbl.backgroundColor = .cyan
        return lbl
    }()
    
    @objc func onClickSubmitBtn() {
        let secondVC = SecondVC()
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.backgroundColor = .lightGray
    }


    func configureUI() {
        self.view.addSubviews(parent: self.view, subviews: [itemLabel, submitBtn])
        itemLabel.centerX(self.view.centerXAnchor)
        itemLabel.centerY(self.view.centerYAnchor)
        
        submitBtn.centerX(self.view.centerXAnchor)
        submitBtn.centerY(self.itemLabel.bottomAnchor, 20)
    }
}

