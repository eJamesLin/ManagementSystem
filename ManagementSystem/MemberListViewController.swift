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

        title = "會員列表"

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reload", style: .plain, target: self, action: #selector(reloadMemberList))

        viewModel.didReloadClosure = { [weak self] (error) in
            DispatchQueue.main.async {
                if let strongSelf = self {
                    MBProgressHUD.hide(for: strongSelf.view, animated: true)
                }

                self?.collectionView?.reloadData()

                if let error = error {
                    self?.showAlert(error: error)
                }
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

    func reloadMemberList() {
        MBProgressHUD.showAdded(to: view, animated: true)
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
