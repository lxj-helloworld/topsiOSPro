//
//  ShowMyNetWorkViewController.swift
//  topsiOSPro_Example
//
//  Created by 李桂盛 on 2019/12/10.
//  Copyright © 2019 李效晋. All rights reserved.
//

import UIKit
import topsiOSPro
import SwiftyJSON
import Alamofire

class ShowMyNetWorkViewController: BaseUIViewViewController {

    let buttons = ["基本请求","上传","下载"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
    }
    func initUI() {
        for i in 0..<buttons.count {
            let button = CommonViews.getPickUIButton(buttons[i])
            baseView.addSubview(button)
            button.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(100 + 100 * i)
                make.centerX.equalTo(baseView.snp.centerX)
            }
            button.tag = 100+i
            button.addTarget(self, action: #selector(btnClick(_ :)), for: .touchUpInside)
        }
    }
    
    @objc func btnClick(_ sender:UIButton) {
        switch sender.tag {
        case 100: ///重连
            let parameters:Parameters = ["loginname":"7886",
                                         "password":"12345678",
                                         "uuid":"105DA37F-B657-45DD-AAE4-5F91D79D0B4E",
                                         "ismobile":"1",
                                         "needToken":"1",
                                         "showLoading":"false"
                ]

            let url = "http://172.20.3.53:8919/toa/toa/toaMobileLogin_login.json";
            self.requestDataWith(url: url, param: parameters, method: .post, dataKey: .dataMap, headers: [:] ,success: { (json) in
                    print(json)
                self.showAlert(message: "\(json)")
            }) { (errorCode) in
                print(errorCode.localizedDescription)
            }
        case 101:
            let keys = ["carid", "datarq", "isinsurance", "dueto", "sgxz", "isrepair", "kycl", "addr", "notes", "flowid", "description"]
            let dic =  ["datarq" : "2020-03-31",
             "flowid" : 19110800000006,
             "addr" : "1",
             "sgxz" : "0",
             "dueto" : "0",
             "carid" : 7,
             "description" : "3",
             "notes" : "2",
             "isinsurance" : "1"] as [String : Any]
            let parameters = JSON(dic)
            let image = UIImage(named: "1")!
            let data = image.pngData()!
            let url = "http://172.20.3.53:89dd19/toa/toa/toaMobileCarAccidentRecord_apply.json"
            self.uploadFileWith(url: url, keys: keys, parameters: parameters, datasArr: [data], datasInfoArr: ["qwqwq"], success: { (json) in
                self.showAlert(message: "\(json)")
            }) { (error) in
                self.showAlert(message: "\(error.localizedDescription)")
            }
        case 102:
            ///19120600000003
            self.downloadFileWith(url: "https://www.tutorialspoint.com/ios/ios_tutorial.pdf", params: [:], success: { (path) in
                print(path)
                self.showAlert(message: path)
            }) { (errorCode) in
                print(errorCode)
//                self.showAlert(message: errorCode)
            }
        default:
            break;
        }
    }

}
