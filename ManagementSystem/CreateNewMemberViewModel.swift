//
//  CreateNewMemberViewModel.swift
//  ManagementSystem
//
//  Created by CJ Lin on 2017/2/25.
//  Copyright © 2017年 cj. All rights reserved.
//

import UIKit

class CreateNewMemberViewModel: NSObject {

    var didGetResponseClosure:((Error?)->Void)?

    func checkInput(username: String?) -> (Bool, String?) {
        guard let username = username, username.characters.count > 0 else {
            return (false, "請輸入會員姓名")
        }

        if username.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty {
            return (false, "請輸入空白以外的字元")
        }

        //
        // ....
        // other check list
        //

        return (true, nil)
    }

    func createMemberWithUsername(_ username: String) {
        APIManager.shared().createNewMember(withUsername: username) { [weak self] (error) in
            if let closure = self?.didGetResponseClosure {
                closure(error)
            }
        }
    }
}
