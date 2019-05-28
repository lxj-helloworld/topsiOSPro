//
//  BaseUIViewViewController.swift
//  TopsProSys
//
//  Created by topscommmac01 on 2018/10/24.
//  Copyright © 2018年 com.topscommmac01. All rights reserved.
//

import UIKit
import SnapKit

class BaseUIViewViewController: BaseViewController {

    var baseView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBaseView()
    }
    
    //初始化基础视图
    func initBaseView() {
        baseView = UIView()
        baseView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubview(baseView)
        baseView.snp.makeConstraints{(make) -> Void in
            if #available(iOS 11.0, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.top.equalTo(topLayoutGuide.snp.bottom)
                make.bottom.equalTo(bottomLayoutGuide.snp.bottom)
            }
             make.left.right.equalTo(view)
        }
    }
    
   

}
