//
//  MenuViewController.swift
//  ManagementSystem
//
//  Created by CJ Lin on 2017/2/23.
//  Copyright © 2017年 cj. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {

    var didTapLogoutClosure:(()->Void)?
    var didTapMemberListClosure:(()->Void)?
    var didTapNewMemberClosure:(()->Void)?

    fileprivate enum MenuSetting: Int {
        case memberList
        case createNewMember
        case logout

        func displayName() -> String {
            switch self {
            case .memberList: return "會員列表"
            case .logout: return "登出"
            case .createNewMember: return "新增會員"
            }
        }
    }

    fileprivate func action(menu: MenuSetting) -> (()->Void)? {
        switch menu {
        case .memberList: return didTapMemberListClosure
        case .logout: return didTapLogoutClosure
        case .createNewMember: return didTapNewMemberClosure
        }
    }

    fileprivate var dataSource: [MenuSetting] = [.memberList, .createNewMember, .logout]
    fileprivate let reuseIdentifier = "reuseIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
        tableView.tableFooterView = UIView()
    }

    #if DEBUG
    deinit {
        print("\(#file) \(#function)")
    }
    #endif
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MenuViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        let model = dataSource[indexPath.row]
        cell.textLabel?.text = model.displayName()

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = dataSource[indexPath.row]
        if let closure = action(menu: model) {
            closure()
        }
    }
}
