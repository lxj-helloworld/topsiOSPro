//
//  ListBaseViewController.swift
//  topsiOSPro_Example
//
//  Created by 李桂盛 on 2019/11/28.
//  Copyright © 2019 李效晋. All rights reserved.
//

import UIKit
import JXSegmentedView
import topsiOSPro

class ListBaseViewController: BaseUIViewViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        baseView.backgroundColor = UIColor(red: CGFloat(arc4random()%255)/255, green: CGFloat(arc4random()%255)/255, blue: CGFloat(arc4random()%255)/255, alpha: 1)
        //MARK：-记得调整baseView的frame
        baseView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}

extension ListBaseViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        
        return view
    }
}
