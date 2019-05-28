//
//  BaseViewController.swift
//  TopsProSys
//  页面基类
//  Created by topscommmac01 on 2018/10/22.
//  Copyright © 2018年 com.topscommmac01. All rights reserved.
//
import Foundation
import UIKit
import SnapKit
import SwiftyJSON
import Alamofire
import QorumLogs
import IQKeyboardManagerSwift

class BaseViewController: UIViewController {
    var keyHeight:CGFloat = 305 //键盘的高度
    
    //分页参数
    var page:Int = 1
    var sidx:String = ""
    var sord:String = ""
    //    获取token
//    var token:String? = UserDefaults.standard.string(forKey: "token")
//    var httpHeader = ["Authorization":""]
    
    //状态栏高度
    public var statusBarHeight:CGFloat!
    //导航栏高度
    public var navigationItemHeight:CGFloat!
    //基础视图距离顶部高度
    public var topMarginHeight:CGFloat! = 0
    
    
//    let roundEntryViewWidth:CGFloat = 80
//    let roundEntryViewMargin:CGFloat = 20
//    var myFloatRoundEntryView:MyFloatRoundEntryView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
//        if token != nil {
//            httpHeader = ["Authorization":token!]  //  重新赋值token
//        }
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        initHeader()
        
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.keyboardWillChangeFrame(node:)), name: UIResponder.keyboardWillShowNotification, object: nil)
     
        logConfig()
        keyboardConfig()
        navigationBarConfig()

    }
    
    func initHeader(){
        let navRect = self.navigationController?.navigationBar.frame;
        
        self.navigationItemHeight = navRect?.size.height
        self.statusBarHeight = UIApplication.shared.statusBarFrame.height
        if self.navigationItemHeight != nil,self.statusBarHeight != nil {
            self.topMarginHeight = self.navigationItemHeight + self.statusBarHeight
        }
//        QL1("self.navigationItemHeight = \(self.navigationItemHeight)")
//        QL1("self.statusBarHeight = \(self.statusBarHeight)")
//        QL1("self.topMarginHeight = \(self.topMarginHeight)")
//        QL1("屏幕方向 是否纵向 = \(UIDevice.current.orientation.isPortrait)")
//        QL1("屏幕方向 是否横向= \(UIDevice.current.orientation.isLandscape)")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    //日志框架配置
    func logConfig() {
        if !NetConstants.isBanLog{
            QorumLogs.enabled = true //日志开关,默认为false
        }
        //        QorumLogs.test() //测试方法
        //        QL1("debug") //打印
        //        QL2("info")
        //        QL3("warn")
        //        QL4("error")
        //        QLPlusLine() //横线
        //        QLShortLine() //横线
        //        QorumLogs.colorsForLogLevels[0] = QLColor(r: 255, g: 255, b: 0) //设置日志颜色
    }
    
    //键盘配置,属性很多,未写全
    func keyboardConfig(){
        IQKeyboardManager.shared.enable = true //开启自动键盘功能,默认开启
        //键盘toobar
//        IQKeyboardManager.shared.enableAutoToolbar = false //显示键盘上面toobar,默认开启
        //xx.inputAccessoryView = UIView()  //如果某一个输入框不需要toobar 使用该方式隐藏
//        IQKeyboardManager.shared.toolbarPreviousBarButtonItemImage = UIImage() //toobar 左侧上图标
//        IQKeyboardManager.shared.toolbarNextBarButtonItemImage = UIImage() //toobar 左侧下图标
//        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "完成" //toobar 右侧文字
//        IQKeyboardManager.shared.shouldResignOnTouchOutside = true //点击背景 键盘收回,默认关闭
        IQKeyboardManager.shared.enableDebugging = false //关闭调试信息
    }
    
    //设置导航栏样式
    func navigationBarConfig(){
//        self.navigationItem.hidesBackButton = true
//        let leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(goBack))
//        self.navigationItem.setLeftBarButton(leftBarButtonItem, animated: true)
//        self.navigationController?.navigationBar.tintColor = ConstantsHelp.tintColor
//        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 17, weight: .regular)]
    }
    
    
    //键盘弹出
    @objc private func keyboardWillChangeFrame(node : Notification){
        //1.获取动画执行的时间
        let duration =  node.userInfo!["UIKeyboardAnimationDurationUserInfoKey"] as! Double
        //2. 获取键盘最终的Y值
        let endFrame = (node.userInfo!["UIKeyboardFrameEndUserInfoKey"] as! NSValue).cgRectValue
        keyHeight = endFrame.origin.y
        //3.计算工具栏距离底部的间距
        keyHeight =  UIScreen.main.bounds.height - keyHeight + CGFloat(ConstantsHelp.uiTextFieldHeight*3/2)
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        QL1("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//        QL1("viewDidAppear")
//        QL1("当前显示视图：\(self.description)  当前视图控制器数量： \(String(describing: self.navigationController?.viewControllers.count))")
        if let viewControllerCount = self.navigationController?.viewControllers.count {
            if viewControllerCount > 2 {
                showFloatButton()
            }else{
                hideFloatButton()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
//        QL1("viewWillDisappear")
//        QL1("有旧视图销毁 当前视图控制器数量： \(self.navigationController?.viewControllers.count)")
    }
    
    @objc func goBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    //根据请求地址和请求参数请求ActionResult，
    func getResultActionOnly(urlRequest :String,parameters:Parameters?,backToActionResultFunc : @escaping (_ actionResult:JSON) -> Void)  {
//         QL1("tokenHeder\(httpHeader)")
        showLoading(isSupportClick: true)
        Alamofire.request(urlRequest, method: HTTPMethod.post,parameters: parameters).validate().responseJSON{
            response in
//            QL1("response.request = \(response.request)")
            switch response.result{
            case .success:
                self.hideHUD()
                if let data = response.data {
//                    QL1("data = \(JSON(data))")
                    let actionResult:JSON  = JSON(data)[ConstantsHelp.actionReuslt]
                    if actionResult[ConstantsHelp.success].boolValue {
                        backToActionResultFunc(actionResult)
                    }else{
                        if JSON(data)[ConstantsHelp.timeout].boolValue{ //登陆超时
                            self.loginAgain()
                        }else{
                            self.showAlertOne(title: "提示",message: actionResult[ConstantsHelp.message].stringValue)
                        }
                    }
                }
            case .failure(let error):
                self.hideHUD()
                self.showAlertOne(title: "", message: "似乎已断开与互联网的连接")
                QL1("BaseViewController getResultActionOnly 似乎已断开与互联网的连接 failure \(error)")
            }
        }
    }
    
    
    //根据请求地址和参数请求map类数据
    func getResultMap(urlRequest :String,parameters:Parameters?,isSupportClick:Bool = true,backToMapFunc : @escaping (_ map:JSON) -> Void)  {
//        QL1("tokenHeder\(httpHeader)")
        if let show = parameters!["showLoading"]{
            QL1("show = \(show)")
        }else{
            showLoading(isSupportClick: isSupportClick)
        }
        
        Alamofire.request(urlRequest, method: HTTPMethod.post, parameters: parameters).validate().responseJSON{
            response in
//            QL1("response.request = \(String(describing: response.request))")
//            QL1("Parameters = \(String(describing: parameters))")
            switch response.result{
            case .success:
                self.hideHUD()
                if let data = response.data {
                    let actionResult:JSON  = JSON(data)[ConstantsHelp.actionReuslt]
//                    QL1("actionResult = \(actionResult)")
//                    QL1("data = \(JSON(data))")
                    if actionResult[ConstantsHelp.success].boolValue {
                        let dataMap:JSON  = JSON(data)[ConstantsHelp.dataMap]
                        backToMapFunc(dataMap)
                    }else{
                       if JSON(data)[ConstantsHelp.timeout].boolValue{  //登陆超时
                           self.loginAgain()
                        }else{
                            self.showAlertOne(title: "提示",message: actionResult[ConstantsHelp.message].stringValue)
                        }
                    }
                }
            case .failure(let error):
                self.hideHUD()
                self.showAlertOne(title: "", message: "似乎已断开与互联网的连接")
                QL1("BaseViewController getResultMap 似乎已断开与互联网的连接 failure \(error)")
            }
        }
    }
    
    //根据请求地址和参数请求所有数据
    func getResultTotalMap(urlRequest :String,parameters:Parameters?,isNeedPop:Bool = false,backToMapFunc : @escaping (_ map:JSON) -> Void)  {
//         QL1("tokenHeder\(httpHeader)")
        if let show = parameters!["showLoading"]{
        }else{
            showLoading(isSupportClick: true)
        }
        Alamofire.request(urlRequest, method: HTTPMethod.post,parameters: parameters).validate().responseJSON{
            response in
            QL1("response.request = \(String(describing: response.request))")
            //            QL1(response.data)
            //            QL1(response.debugDescription)
            //            QL1(response.error)
            //            QL1(response.result)
            //            QL1(response.timeline)
            //            QL1(response.value)
            switch response.result{
            case .success:
                self.hideHUD()
                if let data = response.data {
                    //                    QL1("data = \(JSON(data))")
                    let actionResult:JSON  = JSON(data)[ConstantsHelp.actionReuslt]
                    if actionResult[ConstantsHelp.success].boolValue {
                        let dataMap:JSON  = JSON(data)
                        backToMapFunc(dataMap)
                    }else{
                        if JSON(data)[ConstantsHelp.timeout].boolValue{ //登陆超时
                            self.loginAgain()
                        }else{
                            if !isNeedPop{
                                self.showAlertOne(title: "提示",message: actionResult[ConstantsHelp.message].stringValue)
                            }else{
                                self.showAlertPop(title: "提示", message:actionResult[ConstantsHelp.message].stringValue )
                            }
                        }
                    }
                }
            case .failure(let error):
                self.hideHUD()
                self.showAlertOne(title: "", message: "似乎已断开与互联网的连接")
                QL1("BaseViewController getResultTotalMap 似乎已断开与互联网的连接 failure \(error)")
            }
        }
    }
    
    
    //根据请求地址和参数请求dataList类数据
    func getResultListMap(urlRequest :String,parameters:Parameters,backToListMapFunc : @escaping (_ list:JSON) -> Void)  {
        showLoading(isSupportClick: true)
//         QL1("tokenHeder\(httpHeader)")
        Alamofire.request(urlRequest, method: HTTPMethod.post,parameters: parameters).validate().responseJSON{
            response in
            switch response.result{
            case .success:
                self.hideHUD()
                if let data = response.data {
                    let actionResult:JSON  = JSON(data)[ConstantsHelp.actionReuslt]
                    if actionResult[ConstantsHelp.success].boolValue {
                        let dataList:JSON  = JSON(data)[ConstantsHelp.dataList]
                        backToListMapFunc(dataList)
                    }else{
                        if JSON(data)[ConstantsHelp.timeout].boolValue{  //登陆超时
                            self.loginAgain()
                        }else{
                            self.showAlertOne(title: "提示",message: actionResult[ConstantsHelp.message].stringValue)
                        }
                    }
                }
            case .failure(let error):
                self.hideHUD()
                self.showAlertOne(title: "", message: "似乎已断开与互联网的连接")
                QL1("BaseViewController getResultListMap 似乎已断开与互联网的连接 failure \(error)")
            }
        }
    }
    
    //根据请求地址和参数请求listDataMap类数据
    func getResultlistDataMap(urlRequest :String,parameters:Parameters,backToListMapFunc : @escaping (_ list:JSON) -> Void)  {
        showLoading(isSupportClick: true)
//         QL1("tokenHeder\(httpHeader)")
        Alamofire.request(urlRequest, method: HTTPMethod.post,parameters: parameters).validate().responseJSON{
            response in
            switch response.result{
            case .success:
                self.hideHUD()
                if let data = response.data {
                    let actionResult:JSON  = JSON(data)[ConstantsHelp.actionReuslt]
                    if actionResult[ConstantsHelp.success].boolValue {
                        let listDataMap:JSON  = JSON(data)[ConstantsHelp.listDataMap]
                        backToListMapFunc(listDataMap)
                    }else{
                      if JSON(data)[ConstantsHelp.timeout].boolValue{  //登陆超时
                         self.loginAgain()
                        }else{
                            self.showAlertOne(title: "提示",message: actionResult[ConstantsHelp.message].stringValue)
                        }
                    }
                }
            case .failure(let error):
                self.hideHUD()
//                self.showAlertOne(title: "", message: "似乎已断开与互联网的连接")
                QL1("BaseViewController getResultlistDataMap 似乎已断开与互联网的连接 failure \(error)")
            }
        }
    }
    
    //上传图片
    func postImageList(urlRequest:String,keys:[String],parameters:JSON,imagesArr:[Data],imagesInfoArr:[String],isShowLoading:Bool = false, backToInfoFunc : @escaping (_ map:JSON) -> Void)  {
        QL1(keys)
        QL1(parameters)
        QL1(imagesArr)
        QL1(imagesInfoArr)
//        QL1("tokenHeder\(httpHeader)")
        if isShowLoading{
            showLoading(isSupportClick: true)
        }
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            var count = imagesArr.count
            if imagesArr.count != imagesInfoArr.count{
                count = imagesArr.count < imagesInfoArr.count ? imagesArr.count:imagesInfoArr.count // 获取最小值，取最小值，避免两者数量不一致时下面方法取照片时数组越界
            }
            for index in 0..<count {
                let withName = !VerifyHelp.checkImageInfo(imageName: imagesInfoArr[index]) ? "withName" + String(index) + ".png" : imagesInfoArr[index]
                let fileName = !VerifyHelp.checkImageInfo(imageName: imagesInfoArr[index]) ? "fileName" + String(index) + ".png" : imagesInfoArr[index]
                let data = imagesArr[index]
                multipartFormData.append(data, withName: withName, fileName: fileName, mimeType: "image/jpeg")
            }
            if keys.count > 0{
                for value in keys{
                    let data:Data = parameters[value].stringValue.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
                    multipartFormData.append(data, withName:value)
                }
            }
            
        },  to: urlRequest,
            encodingCompletion: { encodingResult in
                QL1("response.request = \(encodingResult)")
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if let value = response.result.value as? [String: AnyObject]{
                            if isShowLoading{
                                self.hideHUD()
                            }
                            let json = JSON(value)
                            let actionResult = json["actionResult"]
                            if actionResult["success"].boolValue {
                                backToInfoFunc(actionResult)
                            }else{
                                if json[ConstantsHelp.timeout].boolValue{ //登陆超时
                                    self.loginAgain()
                                }else{
                                    backToInfoFunc(actionResult)
                                    if isShowLoading{
                                        self.showAlertOne(title: "", message: "提交失败：\(actionResult["message"])")
                                    }
                                }
                            }
                        }
                        if  response.error != nil,response.error!._code == NSURLErrorTimedOut{
                            self.hideHUD()
                            self.showAlert(message: "网络连接超时!\n请检查网络后重试")
                        }
                    }
                case .failure(let encodingError):
                    self.hideHUD()
                    self.showAlert(message:"提交失败,错误原因为:\(encodingError)")
                    QL1(encodingError)
                }
        })
    }
    
    
    //登录超时，进行重启
    func loginAgain() {
        QL1("登录超时")
        if !SingletonHelp.getSingletonHelp().isTimeOut{
            SingletonHelp.getSingletonHelp().isTimeOut = true
            loginAgainToast()
        }
    }
    
    //弹出登录超时toast
    func loginAgainToast(){
        let alertController = UIAlertController(title: "",message: "登录超时,程序重启", preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
            self.presentedViewController?.dismiss(animated: true, completion:{
                self.backToLogin()
            })
        }
    }
    
    //退回到根视图
    func backToLogin()  {
        self.navigationController?.popToRootViewController(animated: true)
        guard let delegate = UIApplication.shared.delegate as? AppDelegate,let tabBarController = delegate.window?.rootViewController as? UITabBarController, let viewControllers = tabBarController.viewControllers  else {
            return
        }
        for item in viewControllers {
            guard let navController = item as? UINavigationController, let rootViewController = navController.viewControllers.first else { continue }
            if rootViewController is ViewController {
                tabBarController.selectedViewController = navController
                break
            }
        }
    }
    
    //退回到指定试图控制器
    func backToHomeViewController()  {
         self.navigationController?.popToViewController((self.navigationController?.viewControllers[1])!, animated: true)
    }
    
    
    // 只有一个按钮的确认提示框,其中按钮内容固定
    func showAlertOne(title:String,message:String) {
        let alertController = UIAlertController(title: title,message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "好的", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // 只有一个按钮的确认提示框,其中title内容为空
    func showAlert(title:String = "",message:String,cancelTitle:String = "好的") {
        let alertController = UIAlertController(title:title,message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //提供回调功能的弹出框
    func showAlertWithCallBack(title:String = "",message:String,okTitle:String = "好的",isShowCancel:Bool = false,cancelTitle:String = "取消",callback:@escaping()->Void) {
        let alertController = UIAlertController(title:title,message:message,preferredStyle: .alert);
        let okAciton = UIAlertAction(title:okTitle,style:.destructive,handler: {action in
            callback()
        })
        if isShowCancel{
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
        }
        alertController.addAction(okAciton)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //用户申请完毕之后弹出返回上一页面
    func showAlertPop(title:String = "",message:String = "提交成功") {
        let alertController = UIAlertController(title:title,message:message,preferredStyle: .alert);
        let okAciton = UIAlertAction(title:"返回",style:.default,handler: {action in
            self.navigationController?.popViewController(animated: true)
        })
        alertController.addAction(okAciton);
        self.present(alertController, animated: true, completion: nil)
    }

    ///自动消失的提示框，其中显示时间为1秒
    func showToast(message:String) {
        let alertController = UIAlertController(title: "",message: message, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
            self.presentedViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    //手机APP在前台运行收到推送 进行弹框
//    func getPushMessage(){
//        QL1(self.presentingViewController)
//        if self.presentingViewController  != nil {
//            return
//        }else{
//            let alertController = UIAlertController(title: "提示",message: "收到新的待办消息！", preferredStyle: .alert)
//            let yesAction = UIAlertAction(title: "查看", style: .destructive, handler: {action in
//                if (UIViewController.current()?.isKind(of: ViewController.self))!{
//                    (UIViewController.current() as! ViewController).autoLoginCheck()
//                }else{
//                    if UIViewController.current()?.isKind(of: BaseWebViewController.self) ?? false {
//                        UIViewController.current()?.navigationController?.popViewController(animated: false)
//                    }
//                    UIViewController.current()?.navigationController?.popToViewController((UIViewController.current()?.navigationController?.viewControllers[1])!, animated: true)
//                    
////                    for i in 0..<(self.navigationController?.viewControllers.count)! {
////                        if self.navigationController?.viewControllers[i].isKind(of: HomeUITabBarViewController.self) == true {
////                            self.navigationController?.popToViewController(self.navigationController?.viewControllers[i] as! HomeUITabBarViewController, animated: true)
////                            break
////                        }
////                    }
//                }
//            })
//            let noAction = UIAlertAction(title: "取消", style: .cancel, handler: { action in
//                if (UIViewController.current()?.isKind(of: ViewController.self))!{
//                    (UIViewController.current() as! ViewController).autoLoginCheck()
//                }
//            })
//            alertController.addAction(noAction)
//            alertController.addAction(yesAction)
//            self.present(alertController, animated: true, completion: nil)
//        }
//    }
    
}

// textField输入键盘控制
extension BaseViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //键盘收回，view放下
        UIView.animate(withDuration: 0.2, animations: {
            self.view.frame.origin.y = 0
        })
        return true
    }
    func textFieldDidBeginEditing(_ textView:UITextField) {
//        //view弹起跟随键盘，高可根据自己定义
//        UIView.animate(withDuration: 0.4, animations: {
//            let uiTextFieldY = textView.frame.origin.y
//            //计算输入框y值距离页面底部距离   补上两个按钮高度
//            let uiTextFieldMarinBottom = ConstantsHelp.SCREENHEIGHT - uiTextFieldY -  CGFloat(2 * ConstantsHelp.uiTextFieldHeight)
//            //如果当前页面键盘高度大于输入框距离底部的距离，将页面上滑；上滑距离为键盘高度减去输入框距离底部的距离；然后加上一个按钮的高度
//            if self.keyHeight > uiTextFieldMarinBottom {
//                self.view.frame.origin.y = -1 * (self.keyHeight - uiTextFieldMarinBottom)
//            }
//        })
    }
}

// textView输入键盘控制
extension BaseViewController:UITextViewDelegate{
    func textViewShouldReturn(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        //键盘收回，view放下
        UIView.animate(withDuration: 0.2, animations: {
            self.view.frame.origin.y = 0
        })
        return true
    }
    func textViewDidBeginEditing(_ textView:UITextView) {
//        if textView.textColor == UIColor.lightGray {
//            textView.text = nil
//            textView.textColor = UIColor.black
//        }
//        //view弹起跟随键盘，高可根据自己定义
//        UIView.animate(withDuration: 0.4, animations: {
//            let uiTextFieldY = textView.frame.origin.y
//            //计算输入框y值距离页面底部距离   补上两个按钮高度
//            let uiTextFieldMarinBottom = ConstantsHelp.SCREENHEIGHT - uiTextFieldY -  CGFloat(ConstantsHelp.uiTextFieldBigHeight )
//            //如果当前页面键盘高度大于输入框距离底部的距离，将页面上滑；上滑距离为键盘高度减去输入框距离底部的距离；然后加上一个按钮的高度
//            if self.keyHeight > uiTextFieldMarinBottom {
//                self.view.frame.origin.y = -1 * (self.keyHeight - uiTextFieldMarinBottom  - CGFloat(ConstantsHelp.uiTextFieldHeight))
//            }
//        })
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            _ = textViewShouldReturn(textView)
            return false
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
    }
}



//获取当前屏幕当前ViewController
extension UIViewController {
    class func current(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return current(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return current(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return current(base: presented)
        }
        return base
    }
}



//悬浮球控制
extension BaseViewController{
    
    func showFloatButton(){
        if KeychainManager.keyChainReadData(identifier: "floatSwitch") == "true" {
            MyFloatWindow.shared.showFloatWindow()
        }
        QL1("显示悬浮窗")
    }
    
    func hideFloatButton(){
        MyFloatWindow.shared.hideFloatWindow()
        QL1("隐藏悬浮窗")
    }
}

