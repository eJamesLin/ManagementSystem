//
//  CreateNewMemberViewController.swift
//  ManagementSystem
//
//  Created by CJ Lin on 2017/2/23.
//  Copyright © 2017年 cj. All rights reserved.
//

import UIKit

class CreateNewMemberViewController: UIViewController {

    lazy var nameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        return textField
    }()

    lazy var actionButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("新增", for: .normal)
        btn.setTitleColor(UIColor.blue, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "新增會員"
        view.backgroundColor = UIColor.white

        view.addSubview(nameField)
        nameField.autoPin(toTopLayoutGuideOf: self, withInset: 20)
        nameField.autoPinEdge(toSuperviewEdge: .leading, withInset: 30)
        nameField.autoPinEdge(toSuperviewEdge: .trailing, withInset: 30)

        view.addSubview(actionButton)
        actionButton.autoPinEdge(.top, to: .bottom, of: nameField, withOffset: 20)
        actionButton.autoAlignAxis(toSuperviewAxis: .vertical)
    }

    #if DEBUG
    deinit {
        print("\(#file) \(#function)")
    }
    #endif

    func didTapActionButton() {

    }
}

extension CreateNewMemberViewController: SlideNavigationControllerDelegate {
    func slideNavigationControllerShouldDisplayLeftMenu() -> Bool {
        return true
    }
}
