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

class ViewController: BaseMenuUICollectionViewViewController {

    //字符串相关
    let stringUIButton = UIButton()
    //校验相关
    let verifyUIButton = UIButton()
    //日期相关
    let dateUIButton = UIButton()
    //网络请求相关
    let requestUIButton = UIButton()
    //网格 菜单
    let menuUIButton = UIButton()
    //列表菜单
    let listMenuUIButton = UIButton()
    
    
    override func viewDidLoad() {
        resourceArray = [["title": "字符串", "image": "AppIcon"],
                         ["title": "日期", "image": "AppIcon"],
                         ["title": "校验", "image": "AppIcon"],
                         ["title": "Http请求", "image": "AppIcon"],
                         ["title": "网格菜单", "image": "AppIcon"],
                         ["title": "列表菜单", "image": "AppIcon"],
        ]
        super.viewDidLoad()
        title = "Topscomm"
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            manageString()
        case 1:
            manageDate()
        case 2:
            verifyData()
        case 3:
            requestData()
        case 4:
            showMenu()
        case 5:
            showListMenu()
        default:
            print("no way to go")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //字符串相关
     func manageString(){
        let stringViewController = StringViewController()
        stringViewController.title = "字符串相关"
        self.navigationController?.pushViewController(stringViewController, animated: true)
    }

    //日期相关
    func manageDate(){
        let viewController = DateHelpViewController()
        viewController.title = "日期相关"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    //校验相关
    func verifyData(){
        let stringViewController = VerifyDataViewController()
        stringViewController.title = "值校验"
        self.navigationController?.pushViewController(stringViewController, animated: true)
    }

   
    
    func requestData(){
        let requestViewController = RequestViewController()
        requestViewController.title = "数据请求"
        self.navigationController?.pushViewController(requestViewController, animated: true)
    }
    
    func showMenu(){
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
    
     func showListMenu(){
        let myListMenuViewController = MyListMenuViewController()
        myListMenuViewController.title = "列表菜单"
        myListMenuViewController.valueDirect = [0:["第一个菜单项"],
                                                1:["第二个菜单项01","第二个菜单项02"],
                                                2:["第三个菜单项"],
                                                3:["第四个菜单项"],
                                                4:["第五个菜单项"],
                                                5:["第六个菜单项"],
            ] as [Int : [AnyObject]]
        myListMenuViewController.imageDirect = [0:["AppIcon"],
                                                1:["AppIcon","AppIcon"],
                                                2:["AppIcon"],
                                                3:["AppIcon"],
                                                4:["AppIcon"],
                                                5:["AppIcon"],
            ] as [Int : [AnyObject]]
        
        self.navigationController?.pushViewController(myListMenuViewController, animated: true)
    }
    

}

