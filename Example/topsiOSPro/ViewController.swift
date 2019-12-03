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
                         ["title": "钥匙串存储", "image": "AppIcon"],
                         ["title": "本地图片预览", "image": "AppIcon"],
                         ["title": "在线图片预览", "image": "AppIcon"],
                         ["title": "设备信息", "image": "AppIcon"],
                         ["title": "基础控制器", "image": "AppIcon"],
                         ["title": "本地推送", "image": "AppIcon"],
                         ["title": "基本视图", "image": "AppIcon"],
                         ["title": "选择器", "image": "AppIcon"],
                         ["title": "滑动/点击切换", "image": "AppIcon"],
                         ["title": "搜索+列表", "image": "AppIcon"]
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
        case 6:
            keychainManage()
        case 7:
            showLocalImages()
        case 8:
            showNetImages()
        case 9:
            showNoti()
        case 10:
            showMyList()
        case 11:
            showLocalNoti()
        case 12:
            showNormalView()
        case 13:
            showPickerView()
        case 14:
            showSegmentView()
        case 15:
            showSearchAndTable()
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
    
    
    //钥匙串存储
    func keychainManage(){
        let stringViewController = KeyChainViewController()
        stringViewController.title = "钥匙串存储"
        self.navigationController?.pushViewController(stringViewController, animated: true)
    }

    //本地图片预览
    func showLocalImages(){
        let viewController = ShowLocalImageViewController()
        viewController.title = "本地图片"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    //网络图片预览
    func showNetImages(){
        let viewController = ShowNetImageViewController()
        viewController.title = "网络图片"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    //设备信息
    func showNoti(){
        let viewController = ShowDeviceInfoViewController()
        viewController.title = "设备信息"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    //基础视图
    func showMyList(){
        let viewController = MyListMenuViewController()
        viewController.title = "基础控制器"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    //本地推送
    func showLocalNoti(){
        let viewController = ShowLocalNotiViewController()
        viewController.title = "本地推送"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    //基本视图
    func showNormalView(){
        let viewController = ShowMyViewViewController()
        viewController.title = "基本视图"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    //选择器
    func showPickerView(){
        let viewController = ShowPickerViewController()
        viewController.title = "基本视图"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    //切换/点击视图
    func showSegmentView(){
        let viewController = ShowSegmentListViewController()
        viewController.title = "基本视图"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    //搜索+列表
    func showSearchAndTable() {
        let viewController = ShowMySearchAndTableViewController()
        viewController.title = "基本搜索列表"
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
}

