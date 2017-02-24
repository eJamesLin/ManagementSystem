//
//  MemberListViewModel.swift
//  ManagementSystem
//
//  Created by CJ Lin on 2017/2/24.
//  Copyright © 2017年 cj. All rights reserved.
//

import UIKit

class MemberListViewModel: NSObject {

    var didReloadClosure:((_ error: Error?, _ tokenValid: Bool)->Void)?
    var model: [MemberModel]?

    func numberOfModels() -> Int {
        return model?.count ?? 0
    }

    func modelAt(index: Int) -> MemberModel? {
        guard let model = model, index < model.count else { return nil }
        return model[index]
    }

    func reloadData() {
        APIManager.shared().getMemberList { [weak self] (modelArray, error, tokenValid) in

            if error == nil {
                self?.model = modelArray
            }

            if let closure = self?.didReloadClosure {
                closure(error, tokenValid)
            }
        }
    }

}
