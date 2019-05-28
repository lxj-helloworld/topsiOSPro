//
//  StringViewController.swift
//  topsiOSPro_Example
//
//  Created by topscommmac01_lixiaojin on 2019/5/28.
//  Copyright © 2019 李效晋. All rights reserved.
//

import UIKit
import SnapKit
import topsiOSPro

class StringViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        let getPrefixNStrUIButton = UIButton()
        getPrefixNStrUIButton.setTitle("截取backgroundColor的前6字符串", for: .normal)
        getPrefixNStrUIButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.view.addSubview(getPrefixNStrUIButton)
        getPrefixNStrUIButton.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(30)
        }
        getPrefixNStrUIButton.addTarget(self, action: #selector(getPrefixNStr(button:)), for: .touchDown)
    }
    

    @objc func getPrefixNStr(button:UIButton){
        let result:String = StringUtils.getPrefixNStr(button.titleLabel?.text,6)
        
        
    }

}
