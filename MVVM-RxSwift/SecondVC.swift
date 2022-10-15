//
//  SecondVC.swift
//  MVVM-RxSwift
//
//  Created by Shavkat Khoshimov on 15/10/22.
//

import UIKit

class SecondVC: UIViewController {

    lazy var goBackBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("go back", for: .normal)
        btn.backgroundColor = .cyan
        btn.addTarget(self, action: #selector(onClickGoBackBtn), for: .touchUpInside)
        return btn
    }()
    
    lazy var itemLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "second item label"
        lbl.backgroundColor = .cyan
        return lbl
    }()
    
    @objc func onClickGoBackBtn() {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.backgroundColor = .systemYellow
    }


    func configureUI() {
        self.view.addSubviews(parent: self.view, subviews: [itemLabel, goBackBtn])
        itemLabel.centerX(self.view.centerXAnchor)
        itemLabel.centerY(self.view.centerYAnchor)
        
        goBackBtn.centerX(self.view.centerXAnchor)
        goBackBtn.centerY(self.itemLabel.bottomAnchor, 20)
    }
}

