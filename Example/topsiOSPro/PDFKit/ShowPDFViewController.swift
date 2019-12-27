//
//  ShowPDFViewController.swift
//  topsiOSPro_Example
//
//  Created by 李桂盛 on 2019/12/27.
//  Copyright © 2019 李效晋. All rights reserved.
//

import UIKit
import topsiOSPro

@available(iOS 11.0, *)
class ShowPDFViewController: BasePDFKitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.urlString = "https://www.tutorialspoint.com/ios/ios_tutorial.pdf"
//        self.urlString = "http://172.20.3.53:8919/toa/cbo/cboAttachment_download.action?attachmentId=19091600001003"
    }
    

}
