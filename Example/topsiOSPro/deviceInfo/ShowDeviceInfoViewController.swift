//
//  ShowDeviceInfoViewController.swift
//  topsiOSPro_Example
//
//  Created by 李桂盛 on 2019/11/20.
//  Copyright © 2019 李效晋. All rights reserved.
//

import UIKit
import topsiOSPro

class ShowDeviceInfoViewController: BaseUIViewViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let verifyUIButton = UIButton()
        verifyUIButton.setTitle("这是测试testCoreData", for: .normal)
        verifyUIButton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.view.addSubview(verifyUIButton)
        verifyUIButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide).offset(30)
            } else {
                make.top.equalTo(topLayoutGuide.snp.top)
            }
            make.height.equalTo(35)
        }
        if #available(iOS 10.0, *) {
            verifyUIButton.addTarget(self, action: #selector(verifyData(button:)), for: .touchDown)
        }
    }
    @available(iOS 10.0, *)
    @objc func verifyData(button:UIButton){
        var result = ""
        if  let info1 = DeviceInfoUtils.deviceName, let info2 = DeviceInfoUtils.devicesySystemVersion{
            result += "设备名称:\(info1)  版本：\(info2)"
            self.view.show(text: result)
        }        
    }


}
