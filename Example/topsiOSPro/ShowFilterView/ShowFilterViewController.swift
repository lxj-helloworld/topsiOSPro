//
//  ShowFilterViewController.swift
//  topsiOSPro_Example
//
//  Created by 李桂盛 on 2019/12/7.
//  Copyright © 2019 李效晋. All rights reserved.
//

import UIKit
import topsiOSPro
import IQKeyboardManagerSwift
import Alamofire

class ShowFilterViewController: BaseUIViewViewController,UIGestureRecognizerDelegate {

    let bavkV = UIView()
    var filterView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        IQKeyboardManager.shared.enable = true
        
        showFilterView()
        

//        let parameters:Parameters = ["loginname":"7886",
//                                     "password":"123456ggg",
//                                     "uuid":"105DA37F-B657-45DD-AAE4-5F91D79D0B4E",
//                                     "ismobile":"1",
//                                     "needToken":"1",
//                                     "showLoading":"false"
//            ] as [String : Any]
//
//        let url = "http://172.20.3.53:8919/toa/toa/toaMobileLogin_login.json";
//
//        self.requestDataWith(url: url, param: parameters, method: .post, dataKey: .dataMap, headers: [:], success: { (json) in
//            print(json)
//        }) { (errorCode) in
//            print(errorCode)
//        }
        
        ///

        
    }
    func showFilterView() {
         filterView = CommonViews.getFilterView(headerTitle: "enenen", contentTitles: [["key":ConstantsHelp.UIViewType.uibutton.rawValue,"value":"uibutton"],                                                                                    ["key":ConstantsHelp.UIViewType.uitextField.rawValue,"value":"uitextField"],                                                                                        ["key":ConstantsHelp.UIViewType.uitextField.rawValue,"value":"uitextField"],
        ],cancleButtonTitle: "Cancle",sureButtonTitle: "OKOKOK")
        
        if let window = ConstantsHelp.keywindows() {
            
            bavkV.frame = window.bounds
            bavkV.addSubview(filterView)
            bavkV.backgroundColor = UIColor.init(white: 0, alpha: 0.6)
            baseView.addSubview(bavkV)
            filterView.snp.makeConstraints { (make) in
                make.center.equalTo(bavkV.snp.center)
                make.width.equalToSuperview().multipliedBy(0.9)
            }
            window.addSubview(bavkV)
        }
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClick(_ :)))
        tap.delegate = self
        bavkV.addGestureRecognizer(tap)
        
        
    }
    
    @objc func tapClick(_ tap: UITapGestureRecognizer) {
        bavkV.removeFromSuperview()
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: filterView))! {
            return false
        }
        return true
    }

}
