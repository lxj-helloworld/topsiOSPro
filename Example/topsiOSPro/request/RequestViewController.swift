//
//  RequestViewController.swift
//  topsiOSPro_Example
//
//  Created by topscommmac01_lixiaojin on 2019/5/31.
//  Copyright © 2019 李效晋. All rights reserved.
//

import UIKit
import topsiOSPro
import SwiftyJSON
import SnapKit
import QorumLogs
import Alamofire

class RequestViewController: BaseUIScrollViewViewController {

    //登录
    let loginUIButton = UIButton()
    //请求dataMap
    let dataMapUIButton = UIButton()
    //请求所有
    let allUIButton = UIButton()
    //请求dataList
    let dataListUIButton = UIButton()
    //请求listDataMap
    let listDataMapUIButton = UIButton()
    //数据展示
    let resultUILabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
    

    func initView(){
        self.innerUIView.addSubview(loginUIButton)
        loginUIButton.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
        }
        loginUIButton.addTarget(self, action: #selector(loginTo), for: .touchDown)
    }
    
    
    @objc func loginTo(){
        let parameters: Parameters = ["loginname":"0903","password":"lxj010203,.","uuid":"idfa","ismobile":"1"]
        let url = "http://172.20.3.53:8919/toa/toa/toaMobileLogin_login.json";
        getResultMap(urlRequest: url, parameters: parameters) { (json) in
            print("json = \(json)")
        }
    }
    

}
