//
//  HelloWorld.swift
//  FBSnapshotTestCase
//
//  Created by topscommmac01_lixiaojin on 2019/5/25.
//

import Foundation

public class HelloWorld:NSObject {
    override init() {
        super.init()
    }
    public class func hello(){
        print("this is in hello !")
    }
    public static let words = "mine is words !"
}
