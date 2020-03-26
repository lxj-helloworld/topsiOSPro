//
//  ListBaseUIViewController.swift
//  topsiOSPro_Example
//  segment下 更通用的baseUIViewController
//  Created by 李桂盛 on 2020/3/26.
//  Copyright © 2020 李效晋. All rights reserved.
//

import UIKit
import topsiOSPro

class ListBaseUIViewController: BaseSegmentCommonViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let red = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        let green = CGFloat( arc4random_uniform(255))/CGFloat(255.0)
        let blue = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        let alpha = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        baseView.backgroundColor = UIColor.init(red:red, green:green, blue:blue , alpha: alpha)
        
        let label = CommonViews.getUILabel(title: "\(arc4random())")
        baseView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }

}
