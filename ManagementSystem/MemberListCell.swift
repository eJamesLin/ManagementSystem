//
//  MemberListCell.swift
//  ManagementSystem
//
//  Created by CJ Lin on 2017/2/23.
//  Copyright © 2017年 cj. All rights reserved.
//

import UIKit

class MemberListCell: UICollectionViewCell {

    lazy var label: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = UIColor.darkGray
        return lbl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        contentView.addSubview(label)
        label.autoAlignAxis(toSuperviewAxis: .vertical)
        label.autoAlignAxis(toSuperviewAxis: .horizontal)
    }
}
