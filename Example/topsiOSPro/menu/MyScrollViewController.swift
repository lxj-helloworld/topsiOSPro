//
//  MyScrollViewController.swift
//  topsiOSPro_Example
//
//  Created by 李桂盛 on 2019/11/20.
//  Copyright © 2019 李效晋. All rights reserved.
//

import UIKit
import topsiOSPro

class MyScrollViewController: BaseUIScrollViewViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
    }
    
     func addViews() {
        baseScrollView.backgroundColor = .lightGray
        
        let base = UIView()
        base.backgroundColor = .red
        baseScrollView.addSubview(base)
        base.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalTo(ConstantsHelp.SCREENWITH)
        }
        
        let view2 = UIView()
        view2.backgroundColor = .green
        base.addSubview(view2)
        view2.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(400)
        }
        
        base.snp.makeConstraints { (make) in
            make.bottom.equalTo(view2.snp.bottom).offset(40)
        }
        
    }
    

}
