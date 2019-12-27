//
//  MyWebViewController.swift
//  topsiOSPro_Example
//
//  Created by 李桂盛 on 2019/11/22.
//  Copyright © 2019 李效晋. All rights reserved.
//

import UIKit
import topsiOSPro

class MyWebViewController: ProgressWebViewController {
    
    public let appDeleagte = UIApplication.shared.delegate  as! AppDelegate
    public var isPortrait = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK:-设置cookie
//        var cookieProperties = [HTTPCookiePropertyKey:String]()
//        cookieProperties[HTTPCookiePropertyKey.name] = "JSESSIONID" as String
//        cookieProperties[HTTPCookiePropertyKey.value] = "B77C0AA2444901DC555C3F158615285C" as String
//        cookieProperties[HTTPCookiePropertyKey.domain] = "172.20.3.53" as String
//        cookieProperties[HTTPCookiePropertyKey.path] = "/er" as String
//        
//        self.cookies = [HTTPCookie(properties: cookieProperties)!]
        //NARK:-设置headers
        self.headers = ["Authorization":UserDefaults.standard.value(forKey: "token") as! String]
        // Do any additional setup after loading the view.
    }
//    override func rotateDidClick(sender: AnyObject) {
//        if isPortrait{
//            appDeleagte.allowRotation = true
//            isPortrait = false
//            let value = UIInterfaceOrientation.landscapeRight.rawValue
//            UIDevice.current.setValue(value, forKey: "orientation")
//        }else{
//            appDeleagte.allowRotation = false
//            isPortrait = true
//            let value = UIInterfaceOrientation.portrait.rawValue
//            UIDevice.current.setValue(value, forKey: "orientation")
//        }
//    }

}
