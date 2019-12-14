//
//  NetWorkTools.swift
//  TopsProSys
//
//  Created by 李桂盛 on 2019/12/9.
//  Copyright © 2019 com.topscommmac01. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//MARK: - headers 
let networkStaticHeaderKey = "topscommToken"
let Authorization = "Authorization"
let token = "token"

//MARK:- 获取需要数据节点名称
public enum DataKey: String {
    
    case all = "all"
    case dataMap = "dataMap"
    case dataList = "dataList"
    case listDataMap = "listDataMap"
    case actionResult = "actionResult"
    case none = "none"
}
//MARK:-网络请求类型
public enum NetWorkType {
    case normalRequest
    case upload
    case download
}
//MARK:- 错误码
public enum ErrorCode{
    //200...299
    case invalidResponse(String)
    //actionResult中的 ’success‘为false
    case sysError(String)
    //其他错误 如 ‘failure’ 返回HTTP状态码 以及 错误信息描述
    case networkUnavailable(String?,Int?)
    //重试
    /** @param URLRequest  失败的request
     * @param NetWorkType 请求类型
     * @param DataKey     获取数据的参数
     * @param String      错误信息
     */
    case needRetrier(URLRequest,NetWorkType,DataKey?,String)
    /**
     * 上传失败 回调参数
     * @param String           请求地址
     * @param [String]         参数
     * @param JSON             整个数据
     * @param [Data]           数据信息
     * @param [String]         数据信息描述
     * @param String?          错误信息
     */
    case uploadError(String,[String],JSON,[Data],[String],String?)
}

public typealias Success<T> = (T) -> Void

public typealias Failure = (ErrorCode) -> Void

public final class NetWorkTools {
    
    private init() {}
    
    static let shared = NetWorkTools()
    
    
    var sessionManger: SessionManager = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        let manger = Alamofire.SessionManager(configuration: config)
        return manger
    }()
    
}
extension NetWorkTools {
    /**
     * 基本请求方法
     * @param url             请求地址
     * @param param           参数
     * @param method          post get
     * @param dataKey         获取的数据部分 例如 data 下面的 ‘dataList’部分
     * @param headers         请求头
     * @param isNeedReConnect 需要重连 默认true 重连3次
     * @param success         成功回调
     * @param failure         失败回调
     */
    public static func getNormalRequestWith(url: String,
                                         param: Parameters,
                                         networkType:NetWorkType,
                                         method: HTTPMethod = .post,
                                         dataKey: DataKey = .all,
                                         success: @escaping Success<JSON>,
                                         failure: @escaping Failure) {
        
        var headers: [String:String] {
            if let headerValue = UserDefaults.standard.value(forKey: networkStaticHeaderKey) as? String {
                return [Authorization : headerValue]
            }
            return [:]
        }
        
        shared.sessionManger.request(url, method: method, parameters: param, encoding: URLEncoding.default, headers: headers)
            .validate() //200...299
            .responseJSON { (response) in

                switch response.result {
                case .success:
                    if let data = response.data{
                        let actionReuslt = JSON(data)[ConstantsHelp.actionReuslt]
                        if actionReuslt[ConstantsHelp.success].boolValue {
                            let json = JSON(data)[dataKey.rawValue]
                            //MARK:-存token
                            if  !JSON(data)[ConstantsHelp.dataMap][token].stringValue.isEmpty {
                                UserDefaults.standard.set(JSON(data)[ConstantsHelp.dataMap][token].stringValue, forKey: networkStaticHeaderKey)
                            }
                            success(json)
                        } else {
                            let message = (actionReuslt[ConstantsHelp.message].stringValue)
                            failure(.sysError(message))
                            
                        }
                    }
                case .failure(let error):
                    if let code = response.response?.statusCode {
                        if code == 500 || code == 502 || code == 503 || code == 504{
                            if let request = response.request {
                                failure(.needRetrier(request, networkType, dataKey, error.localizedDescription))
                            }
                        } else {
                            failure(.sysError(error.localizedDescription))
                        }
                    } else {
                        failure(.sysError(error.localizedDescription))
                    }
                }
        }
    }

    /**
     * 基本上传方法
     * @param url             请求地址
     * @param keys            参数
     * @param parameters      整个数据
     * @param datasArr        数据信息
     * @param datasInfoArr    数据信息描述
     * @param isNeedReConnect 需要重连 默认true 重连3次
     * @param success         成功回调
     * @param failure         失败回调
     */
    public static func uploadRequestWith(url: String,
                                         keys: [String],
                                         parameters: JSON,
                                         datasArr:[Data],
                                         dataKey: DataKey = .actionResult,
                                         datasInfoArr:[String],
                                         networkType:NetWorkType,
                                         success: @escaping Success<JSON>,
                                         failure: @escaping Failure){
        var headers: [String:String] {
            if let headerValue = UserDefaults.standard.value(forKey: networkStaticHeaderKey) as? String {
                return [Authorization : headerValue]
            }
            return [:]
        }
        shared.sessionManger.upload(multipartFormData: { (multipartFormData) in
            //拼接数据
            var count = datasArr.count
            count = datasArr.count <= datasInfoArr.count ? datasArr.count:datasInfoArr.count
            for index in 0..<count {
                let data = datasArr[index]
                
                let withName = !VerifyHelp.checkImageInfo(imageName: datasInfoArr[index]) ? "withName" + String(index) + data.getImageFormat()!: datasInfoArr[index]
                let fileName = !VerifyHelp.checkImageInfo(imageName: datasInfoArr[index]) ? "fileName" + String(index) + data.getImageFormat()! : datasInfoArr[index]
                               
                multipartFormData.append(data, withName: withName, fileName: fileName, mimeType: "application/octet-stream")
            }
            if keys.count > 0{
                for value in keys{
                    let data:Data = parameters[value].stringValue.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
                    multipartFormData.append(data, withName:value)
                }
            }
            
            multipartFormData.append(URL(string:"sss")!, withName: "ss", fileName: "ssd", mimeType: "jpeg/jpg")
            
        }, to: url, headers: headers) { (request) in
            switch request {
            case .success(let upload, _ , _):
                upload.responseJSON { (response) in
                    //是否存在错误
                    if let error = response.error {
                        if let code = response.response?.statusCode {
                            if code == 500 || code == 502 || code == 503 || code == 504 || code == 404{
                                if let request = response.request {
                                    failure(.needRetrier(request, networkType, dataKey, error.localizedDescription))
                                }
                            } else {
                                failure(.sysError(error.localizedDescription))
                            }
                        } else {
                            //offline 无状态码
                            failure(.networkUnavailable(error.localizedDescription, nil))
                        }

                    } else {
                        //成功
                        if let data = response.result.value as? [String : AnyObject] {
                            let actionResult = JSON(data)[ConstantsHelp.actionReuslt]
                            if  actionResult[ConstantsHelp.success].boolValue {
                                success(actionResult)
                            } else {
                                let message = (actionResult[ConstantsHelp.message].stringValue)
                                failure(.sysError(message))
                            }
                        }
                    }
                }
                //MARK:- 验证准备上传的数据是否合法
            case .failure:
                failure(.sysError("上传的数据不合法"))
            }
        }
    }
    /**
     * 基本下载方法
     * @param url             请求地址
     * @param isNeedReConnect 需要重连 默认true 重连3次
     * @param method          HTTPMethod
     * @param params          Parameters
     * @param headers         [String:String]
     * @param success         成功回调
     * @param failure         失败回调
     */
    public static func downloadFileWith(url: String,
                                        method: HTTPMethod = .post,
                                        dataKey: DataKey = .none,
                                        params: Parameters,
                                        networkType:NetWorkType,
                                        success: @escaping Success<String>,
                                        failure: @escaping Failure) {
        var headers: [String:String] {
            if let headerValue = UserDefaults.standard.value(forKey: networkStaticHeaderKey) as? String {
                return [Authorization : headerValue]
            }
            return [:]
        }
        
        let destination: DownloadRequest.DownloadFileDestination = { _, response in
            let documentsURL = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(response.suggestedFilename!)
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        shared.sessionManger.download(url, method: method, parameters: params, encoding: URLEncoding.default, headers: headers, to: destination).responseData { (response) in
            switch response.result {
            case .success:
                if let path = response.destinationURL?.path{
                    if path.hasSuffix("action") {
                        failure(.sysError("下载的文件不存在"))
                    } else {
                        success(path)
                    }
                }else {
                    if let error = response.error {
                        if let code = response.response?.statusCode {
                            if code == 500 || code == 502 || code == 503 || code == 504 ||  code == 504{
                                if let request = response.request {
                                    failure(.needRetrier(request, networkType, dataKey, error.localizedDescription))
                                }
                            } else {
                                failure(.sysError(error.localizedDescription))
                            }
                        }
                    }
                }
            case .failure(let error):
                if let code = response.response?.statusCode {
                    if code == 500 || code == 502 || code == 503 || code == 504 ||  code == 504{
                        if let request = response.request {
                            failure(.needRetrier(request, networkType, dataKey, error.localizedDescription))
                        }
                    } else {
                        failure(.sysError(error.localizedDescription))
                    }
                } else {
                    failure(.sysError(error.localizedDescription))
                }
            }
        }
    }
    
    //MARK:- 重试方法
    public static  func getRetrierRequest(request:URLRequest,
                                           dataKey: DataKey?,
                                           networkType: NetWorkType,
                                           success: @escaping Success<Any>,
                                           failure: @escaping Failure) {
        
        switch networkType {
        case .normalRequest:
            shared.sessionManger.request(request).validate().responseJSON { (response) in
                //在200...299之外
                if let error = response.error {
                    failure(.invalidResponse(error.localizedDescription))
                }
                switch response.result {
                case .success:
                    if let data = response.data{
                        let actionReuslt = JSON(data)[ConstantsHelp.actionReuslt]
                        if actionReuslt[ConstantsHelp.success].boolValue {
                            let json = JSON(data)[dataKey!.rawValue]
                            success(json)
                        } else {
                            let message = (actionReuslt[ConstantsHelp.message].stringValue)
                            failure(.sysError(message))
                        }
                    }
                case .failure(let error):
                    if let code = response.response?.statusCode {
                        if code == 500 || code == 502 || code == 503 || code == 504 {
                            if let request = response.request {
                                failure(.needRetrier(request, networkType, dataKey, error.localizedDescription))
                            }
                        } else {
                            failure(.sysError(error.localizedDescription))
                        }
                    } else {
                        failure(.sysError(error.localizedDescription))
                    }
                }
            }
        case .download:
            let destination: DownloadRequest.DownloadFileDestination = { _, response in
                let documentsURL = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask)[0]
                let fileURL = documentsURL.appendingPathComponent(response.suggestedFilename!)
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            }
            
            shared.sessionManger.download(request, to: destination).validate().responseData { (response) in
                switch response.result {
                case .success:
                    if let path = response.destinationURL?.path{
                        if path.hasSuffix("action") {
                            failure(.sysError("下载的文件不存在"))
                        } else {
                            success(path)
                        }
                    }else {
                        if let error = response.error {
                            if let code = response.response?.statusCode {
                                if code == 500 || code == 502 || code == 503 || code == 504 ||  code == 504{
                                    if let request = response.request {
                                        failure(.needRetrier(request, networkType, dataKey, error.localizedDescription))
                                    }
                                } else {
                                    failure(.sysError(error.localizedDescription))
                                }
                            }
                        }
                    }
                case .failure(let error):
                    if let code = response.response?.statusCode {
                        if code == 500 || code == 502 || code == 503 || code == 504{
                            if let request = response.request {
                                failure(.needRetrier(request, networkType, dataKey, error.localizedDescription))
                            }
                        } else {
                            failure(.sysError(error.localizedDescription))
                        }
                    } else {
                        failure(.sysError(error.localizedDescription))
                    }
                }
            }
        default:
            break;
        }
        
//        shared.sessionManger.request(request).responseJSON { (response) in
//            switch response.result {
//            case .success:
//                if let data = response.data{
//                    let actionReuslt = JSON(data)[ConstantsHelp.actionReuslt]
//                    print(actionReuslt)
//                    if actionReuslt[ConstantsHelp.success].boolValue {
//                        let json = JSON(data)[dataKey.rawValue]
////                        success(json)
//                    } else {
//                        let message = (actionReuslt[ConstantsHelp.message].stringValue)
//                        //                                failure(.sysError(message))
////                        failure(.needRetrier)
//                        //                            response.request
//                    }
//                }
//            case .failure(let error):
//                if let error = error as? AFError {
////                    failure(.networkUnavailable(error.localizedDescription, error._code))
//                }
//            }
//        }
    }
    
}
//MARK:-RequestRetrier
//class NetWorkRetrier: RequestRetrier {
//
//    private var count : Int = 0
//
//    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
//        if count < 3 {
//            completion(true,1)
//            count += 1
//            print(count)
//        } else {
//            completion(false, 0)
//        }
//    }
//
//}
