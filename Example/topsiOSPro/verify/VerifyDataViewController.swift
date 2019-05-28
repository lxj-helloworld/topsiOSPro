//
//  VerifyDataViewController.swift
//  topsiOSPro_Example
//
//  Created by topscommmac01_lixiaojin on 2019/5/28.
//  Copyright © 2019 李效晋. All rights reserved.
//

import UIKit
import topsiOSPro

class VerifyDataViewController: UIViewController {
    let resultUILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    

    override func viewWillAppear(_ animated: Bool) {
        //展示结果
        resultUILabel.numberOfLines = 0
        resultUILabel.lineBreakMode = .byCharWrapping
        self.view.addSubview(resultUILabel)
        resultUILabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide).offset(30)
            } else {
                make.top.equalTo(topLayoutGuide.snp.top)
            }
        }
        
        //
        let verifyUIButton = UIButton()
        verifyUIButton.setTitle("这是测试testCoreData", for: .normal)
        verifyUIButton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.view.addSubview(verifyUIButton)
        verifyUIButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(resultUILabel.snp.bottom).offset(30)
        }
        verifyUIButton.addTarget(self, action: #selector(verifyData(button:)), for: .touchDown)
    }

    @objc func verifyData(button:UIButton){
        var result = "鲁B:123456是车牌号码：" + String(VerifyHelp.isCarNumber(number: "鲁B:123456")) + "\r\n"
        result = result + "12345678901是电话号码：" + String(VerifyHelp.isPhoneNumber(phoneNumber: "12345678901")) + "\r\n"
        resultUILabel.text = result
    }
    
    
}
