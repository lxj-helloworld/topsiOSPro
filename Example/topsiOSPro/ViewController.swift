//
//  ViewController.swift
//  topsiOSPro
//
//  Created by xiaojin20135@live.com on 05/25/2019.
//  Copyright (c) 2019 xiaojin20135@live.com. All rights reserved.
//

import UIKit
import topsiOSPro
import SnapKit

class ViewController: UIViewController {

    //字符串相关
    let stringUIButton = UIButton()
    //校验相关
    let verifyUIButton = UIButton()
    //网络请求相关
    let requestUIButton = UIButton()
    //网格 菜单
    let menuUIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Topscomm"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initString()
        initVerify()
        initRequest()
        initMenu()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initString(){
        stringUIButton.setTitle("字符串相关", for: .normal)
        stringUIButton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.view.addSubview(stringUIButton)
        stringUIButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide).offset(30)
            } else {
                make.top.equalTo(topLayoutGuide.snp.top).offset(30)
            }
        }
        stringUIButton.addTarget(self, action: #selector(manageString), for: .touchDown)
    }
    
    //字符串相关
    @objc func manageString(){
        let stringViewController = StringViewController()
        stringViewController.title = "字符串相关"
        self.navigationController?.pushViewController(stringViewController, animated: true)
    }
    
    
    //校验相关
    func initVerify(){
        verifyUIButton.setTitle("校验相关相关", for: .normal)
        verifyUIButton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.view.addSubview(verifyUIButton)
        verifyUIButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(stringUIButton.snp.bottom).offset(30)
        }
        verifyUIButton.addTarget(self, action: #selector(verifyData), for: .touchDown)
    }
    
    //字符串相关
    @objc func verifyData(){
        let stringViewController = VerifyDataViewController()
        stringViewController.title = "值校验"
        self.navigationController?.pushViewController(stringViewController, animated: true)
    }

    //网络请求相关
    func initRequest(){
        requestUIButton.setTitle("数据请求", for: .normal)
        requestUIButton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.view.addSubview(requestUIButton)
        requestUIButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(verifyUIButton.snp.bottom).offset(30)
        }
        requestUIButton.addTarget(self, action: #selector(requestData), for: .touchDown)
    }
    
    @objc func requestData(){
        let requestViewController = RequestViewController()
        requestViewController.title = "数据请求"
        self.navigationController?.pushViewController(requestViewController, animated: true)
    }
    
    
    //网格菜单
    func initMenu(){
        menuUIButton.setTitle("菜单", for: .normal)
        menuUIButton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.view.addSubview(menuUIButton)
        menuUIButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(requestUIButton.snp.bottom).offset(30)
        }
        menuUIButton.addTarget(self, action: #selector(showMenu), for: .touchDown)
    }
    
    @objc func showMenu(){
        let myMenuViewController = MyMenuViewController()
        myMenuViewController.title = "菜单布局"
        myMenuViewController.resourceArray = [["title": "title", "image": "AppIcon"],
        ["title": "title1", "image": "AppIcon"],
        ["title": "title2", "image": "AppIcon"],
        ["title": "title3", "image": "AppIcon"],
        ["title": "title4", "image": "AppIcon"],
        ["title": "title5", "image": "AppIcon"],
        ]
        self.navigationController?.pushViewController(myMenuViewController, animated: true)
    }
    
}

