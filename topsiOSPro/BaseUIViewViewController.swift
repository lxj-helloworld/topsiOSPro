//
//  BaseUIViewViewController.swift
//  TopsProSys
//
//  Created by topscommmac01 on 2018/10/24.
//  Copyright © 2018年 com.topscommmac01. All rights reserved.
//

import UIKit
import SnapKit

open class BaseUIViewViewController: UIViewController {

    var baseView: UIView!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        initBaseView()
    }
    
    //初始化基础视图
   public func initBaseView() {
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        baseView = UIView()
        baseView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.view.addSubview(baseView)
        baseView.snp.makeConstraints{(make) -> Void in
            if #available(iOS 11.0, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.top.equalTo(self.topLayoutGuide.snp.bottom)
                make.bottom.equalTo(self.bottomLayoutGuide.snp.bottom)
            }
             make.left.right.equalTo(view)
        }
    }
    
   

}
