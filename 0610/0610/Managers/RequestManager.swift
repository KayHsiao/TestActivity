//
//  RequestManager.swift
//  KGI
//
//  Created by mrfour on 3/2/16.
//  Copyright © 2016 mrfour. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SVProgressHUD

/// The Singleton that manages all requests
let requestManager = RequestManager.sharedInstance

enum ServerEnvironment {
    case test
    case production

    // Github API v3
    // 获取repo中某文件信息（不包括内容）。https://api.github.com/repos/用户名/gists/contents/文件路径。文件路径是文件的完整路径，区分大小写。只会返回文件基本信息。
    // 获取某文件的原始内容（Raw）。1. 通过上面的文件信息中提取download_url这条链接，就能获取它的原始内容了。2. 或者直接访问：https://raw.githubusercontent.com/用户名/仓库名/分支名/文件路径
    var domainString: String {
        switch self {
        case .test:
            return "https://raw.githubusercontent.com/2635573591/Activity"
        case .production:
            return "https://正式環境網址"
        }
    }
}

struct AppAPI {
    static func stripURL(_ url: String) -> String {
        return requestManager.serverEnviroment.domainString + url
    }

    static let activitys   = stripURL("/master/activitys.json")
    static let course = stripURL("/master/course.json")
    static let party = stripURL("/master/party.json")
    static let popular = stripURL("/master/popular.json")
    static let hot = stripURL("/master/hot.json")
    static let marqueel = stripURL("/master/marqueel.json")
}

class RequestManager {
    
    static let sharedInstance = RequestManager(.test)
    
    // MARK: Request Configuraion
    
    var serverEnviroment: ServerEnvironment
    
    private init(_ environment: ServerEnvironment) {
        self.serverEnviroment = environment
    }
    
    // MARK: Variables
    
    var currentRequest: Request?

    // MARK: Private Methods
    
    func baseRequest(_ method: Alamofire.HTTPMethod, url: String, parameters: [String: Any]? = nil, needToken: Bool = true, callback: @escaping (_ result :JSON) -> ()) {
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]

//        SVProgressHUD.show()

        currentRequest = Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response -> Void in
                
//                SVProgressHUD.dismiss()

                switch response.result {
                case .success:
                    if let value = response.result.value {
//                        log.info(value)
                        let json = JSON(value)

                        callback(json)
                    }
                case .failure(let error):
//                    let currentVC = appDelegate.findCurrentViewController()
//                    let alertVC = AlertViewController.instantiateFromStoryboard()
//                    alertVC.titleSting = ""
//                    alertVC.messageString = error.localizedDescription
//                    alertVC.confirmString = "確定"
//                    currentVC.present(alertVC, animated: true, completion: nil)
                    return
                }
        }
    }

}

// MARK: - Public Methods

extension RequestManager {
    
    // MARK: Fuction
    
    func cancelRequest() {
        guard let currentRequest = currentRequest else { return }

        log.debug("Canceled current request!!")
        currentRequest.cancel()
    }
    
    // MARK: API

    /// UITabBar 顯示畫面數
    func getActivitys(success: @escaping (_ data: JSON) -> Void) {
        baseRequest(.get, url: AppAPI.activitys, parameters: nil, needToken: false, callback: success)
    }

    /// 所有功能頁
    func getＣourse(success: @escaping (_ data: JSON) -> Void) {
        baseRequest(.get, url: AppAPI.course, parameters: nil, needToken: false, callback: success)
    }

    /// 活动优惠
    func getParty(success: @escaping (_ data: JSON) -> Void) {
        baseRequest(.get, url: AppAPI.party, parameters: nil, needToken: false, callback: success)
    }

    /// 彩金申请
    func getPopular(success: @escaping (_ data: JSON) -> Void) {
        baseRequest(.get, url: AppAPI.popular, parameters: nil, needToken: false, callback: success)
    }

    /// 活动优惠
    func getHot(success: @escaping (_ data: JSON) -> Void) {
        baseRequest(.get, url: AppAPI.hot, parameters: nil, needToken: false, callback: success)
    }

    /// 
    func getMarqueel(success: @escaping (_ data: JSON) -> Void) {
        baseRequest(.get, url: AppAPI.popular, parameters: nil, needToken: false, callback: success)
    }

}
