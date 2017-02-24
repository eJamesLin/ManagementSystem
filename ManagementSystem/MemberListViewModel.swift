//
//  MemberListViewModel.swift
//  ManagementSystem
//
//  Created by CJ Lin on 2017/2/24.
//  Copyright © 2017年 cj. All rights reserved.
//

import UIKit

class MemberListViewModel: NSObject {

    var didReloadClosure:((Error?)->Void)?
    var model: [MemberModel]?

    func numberOfModels() -> Int {
        return model?.count ?? 0
    }

    func modelAt(index: Int) -> MemberModel? {
        guard let model = model, index < model.count else { return nil }
        return model[index]
    }

    func reloadData() {
        APIManager.shared().getMemberList { [weak self] (modelArray, error) in
            //print("\(#file) \(#function) \(modelArray) \(error)")

            if error == nil {
                self?.model = modelArray
            }

            if let closure = self?.didReloadClosure {
                closure(error)
            }
        }
    }
}
