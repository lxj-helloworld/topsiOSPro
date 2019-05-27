//
//  HelloWorld.swift
//  FBSnapshotTestCase
//
//  Created by topscommmac01_lixiaojin on 2019/5/25.
//

import Foundation

open class HelloWorld:NSObject {
    override init() {
        super.init()
    }
    open class func hello(){
        print("this is in hello !")
    }
    open static let words = "mine is words !"
}
