//
//  ViewController.swift
//  topsiOSPro
//
//  Created by xiaojin20135@live.com on 05/25/2019.
//  Copyright (c) 2019 xiaojin20135@live.com. All rights reserved.
//

import UIKit
import topsiOSPro

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("HelloWorld = \(HelloWorld.hello())")
        print("words = \(HelloWorld.words)")


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

