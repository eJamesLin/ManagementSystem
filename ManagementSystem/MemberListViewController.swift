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

    required init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        collectionView?.register(MemberListCell.self, forCellWithReuseIdentifier: reuseID)
        collectionView?.backgroundColor = UIColor.white

        title = "會員列表"
    }

    #if DEBUG
    deinit {
        print("\(#file) \(#function)")
    }
    #endif
}

// MARK: -

extension MemberListViewController: UICollectionViewDelegateFlowLayout {

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseID, for: indexPath)
        if let cell = cell as? MemberListCell {
            cell.label.text = String(indexPath.item)
        }
        return cell
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20 //test
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
