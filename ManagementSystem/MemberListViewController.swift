//
//  MemberListViewController.swift
//  ManagementSystem
//
//  Created by CJ Lin on 2017/2/23.
//  Copyright © 2017年 cj. All rights reserved.
//

import UIKit

class MemberListViewController: UICollectionViewController {

    fileprivate let reuseID = "reuseID"

    fileprivate lazy var viewModel = MemberListViewModel()

    required init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        collectionView?.register(MemberListCell.self, forCellWithReuseIdentifier: reuseID)
        collectionView?.backgroundColor = UIColor.white

        title = "列表"

        let reloadBtn = UIBarButtonItem(image: UIImage(named: "ic_replay"), style: .plain, target: self, action: #selector(reloadMemberList))
        let removeTokenBtn = UIBarButtonItem(title: "移除Token", style: .plain, target: self, action: #selector(removeToken))
        navigationItem.rightBarButtonItems = [removeTokenBtn, reloadBtn]

        viewModel.didReloadClosure = { [weak self] (error, tokenValid) in
            if tokenValid {
                DispatchQueue.main.async {
                    if let strongSelf = self {
                        MBProgressHUD.hide(for: strongSelf.view, animated: true)
                    }

                    self?.collectionView?.reloadData()

                    if let error = error {
                        self?.showAlert(error: error)
                    }
                }
            } else {
                let mainNavi = MainNavigationController.sharedInstance() as? MainNavigationController
                mainNavi?.mainDelegate = self
                mainNavi?.extendToken()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MBProgressHUD.showAdded(to: view, animated: true)
        self.viewModel.reloadData()
    }

    func showAlert(error: Error) {
        let alert = UIAlertController(title: "error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "確認", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "重新載入", style: .default) { [weak self] _ in
            if let strongSelf = self {
                MBProgressHUD.showAdded(to: strongSelf.view, animated: true)
            }
            self?.viewModel.reloadData()
        })
        present(alert, animated: true, completion: nil)
    }

    #if DEBUG
    deinit {
        print("\(#file) \(#function)")
    }
    #endif
}

// MARK: - test

extension MemberListViewController {
    func reloadMemberList() {
        MBProgressHUD.showAdded(to: view, animated: true)
        viewModel.reloadData()
    }

    func removeToken() {
        print("\(#file) \(#function)")
        AppAccount.shared().authToken = nil
    }
}

// MARK: - MainNavigationControllerDelegate

extension MemberListViewController: MainNavigationControllerDelegate {

    func didExtendToken() {
        viewModel.reloadData()
    }
}

// MARK: -

extension MemberListViewController: UICollectionViewDelegateFlowLayout {

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseID, for: indexPath)
        if let cell = cell as? MemberListCell, let model = viewModel.modelAt(index: indexPath.item) {
            cell.label.text = "\(model.identifier) : \(model.name ?? "")"
        }
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfModels()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 30)
    }
}

// MARK: - SlideNavigationControllerDelegate

extension MemberListViewController: SlideNavigationControllerDelegate {

    func slideNavigationControllerShouldDisplayLeftMenu() -> Bool {
        return true
    }
}
