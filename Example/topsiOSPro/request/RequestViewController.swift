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

class RequestViewController: BaseUIViewViewController {

    //登录
    let loginUIButton = UIButton()
    //请求所有
    let allUIButton = UIButton()
    //请求dataList
    let dataListUIButton = UIButton()
    //请求listDataMap
    let listDataMapUIButton = UIButton()
    //数据展示
    let resultUILabel = UILabel()
    
    //resultDataMap
    let resultlistDataMapUIButton = UIButton()
    
    //downloadPDF
    let downloadPDFUIButton = UIButton()
    
    //uploadMutiData
    let uploadMutiDataUIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
    

    func initView(){
        loginUIButton.setTitle("登录", for: .normal)
        loginUIButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.baseView.addSubview(loginUIButton)
        loginUIButton.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
        }
        loginUIButton.addTarget(self, action: #selector(loginTo), for: .touchDown)
        
        allUIButton.setTitle("dataMap", for: .normal)
        allUIButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.baseView.addSubview(allUIButton)
        allUIButton.snp.makeConstraints { (make) in
            make.top.equalTo(loginUIButton.snp.bottom).offset(ConstantsHelp.topMargin)
            make.left.right.equalToSuperview()
        }
        allUIButton.addTarget(self, action: #selector(allGet), for: .touchDown)
        
        resultlistDataMapUIButton.setTitle("ResultlistDataMap", for: .normal)
        resultlistDataMapUIButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.baseView.addSubview(resultlistDataMapUIButton)
        resultlistDataMapUIButton.snp.makeConstraints { (make) in
            make.top.equalTo(allUIButton.snp.bottom).offset(ConstantsHelp.topMargin)
            make.left.right.equalToSuperview()
        }
        resultlistDataMapUIButton.addTarget(self, action: #selector(resultlistDataMap), for: .touchDown)
        
        
        downloadPDFUIButton.setTitle("downloadPDFUIButton", for: .normal)
        downloadPDFUIButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.baseView.addSubview(downloadPDFUIButton)
        downloadPDFUIButton.snp.makeConstraints { (make) in
            make.top.equalTo(resultlistDataMapUIButton.snp.bottom).offset(ConstantsHelp.topMargin)
            make.left.right.equalToSuperview()
        }
        downloadPDFUIButton.addTarget(self, action: #selector(downloadPdf), for: .touchUpInside)
        
        uploadMutiDataUIButton.setTitle("uploadMutiDataUIButton", for: .normal)
        uploadMutiDataUIButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.baseView.addSubview(uploadMutiDataUIButton)
        uploadMutiDataUIButton.snp.makeConstraints { (make) in
            make.top.equalTo(downloadPDFUIButton.snp.bottom).offset(ConstantsHelp.topMargin)
            make.left.right.equalToSuperview()
        }
        uploadMutiDataUIButton.addTarget(self, action: #selector(uploadMutiData), for: .touchUpInside)
    }
    
    
    @objc func loginTo(){
        print("loingTo")
        let parameters:Parameters = ["loginname":"7886",
                                    "password":"123456",
                                    "uuid":"105DA37F-B657-45DD-AAE4-5F91D79D0B4E",
                                    "ismobile":"1",
                                    "needToken":"1",
                                    "showLoading":"false"
            ] as [String : Any]
    
        let url = "http://172.20.3.53:8919/toa/toa/toaMobileLogin_login.json";
        getResultMap(urlRequest: url, parameters: parameters) { (json) in
            self.showAlert(message: "json = \(json)")
            
            UserDefaults.standard.set(json["token"].stringValue, forKey: "token")
        }
    }
    
    @objc func allGet(){
        print("dataMapGet")
        let parameters:Parameters = ["loginName":"0903",
                                     "password":"123456,.",
                                     "baseType":0,
                                     "LastMsgTime":"",
                                     "newMsgIds":"",
                                     "showLoading":"false"
            ] as [String : Any]
        
        let url = "http://172.20.3.53:8918/mobile/userAction_checkLoginForMobile.json";
        getResultTotalMap(urlRequest: url, parameters: parameters) { (json) in
            self.showAlert(message: "json = \(json)")
        }
    }
    
    @objc func resultlistDataMap() {
        let parameters:Parameters = ["rows": "20",
                                     "page": "1",
                                     "sord": "asc",
                                     "sidx": "CboSysParam.category,CboSysParam.module,CboSysParam.code",
                                     "qry_code": "ToaPresentShowPrice"]
            as [String : Any]
        
        self.getResultlistDataMap(urlRequest: "http://172.20.3.53:8919/toa/cbo/cboSysParam_list.json", parameters: parameters) { (json) in
            self.showAlert(message: "\(json)")
        }
    }
    
    @objc func downloadPdf() {
        self.downloadPDF(url: "https://www.tutorialspoint.com/ios/ios_tutorial.pdf") { (path) in
            self.showAlert(message: path)
            debugPrint(path)
        }
    }
    
    @objc func uploadMutiData() {
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
        //http://172.20.3.53:8919/toa/toa/toaMobileCarAccidentRecord_apply.json
        self.postImageList(urlRequest: "http://172.20.3.53:8919/toa/toa/toaMobileCarAccidentRecord_apply.json", keys: keys, parameters: parameters, imagesArr: [data], imagesInfoArr: ["11111"]) { (json) in
            self.showAlert(message: "\(json)")
        }
    }
}
