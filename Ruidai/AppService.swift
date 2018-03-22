//
//  AppService.swift
//  Lottery
//
//  Created by DTY on 2017/4/21.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit
import AdSupport


class AppService: BaseService {
    
    var appInfo: AppInfo!;
    
    func initialApp() {
        //获取idfa 广告标识
        var parameters = Dictionary<String, String>();
        parameters["deviceType"] = "iPhone_\(UIDevice.current.systemName)";
        parameters["sourceChannel"] = "AppStorerd";
        parameters["systemName"] = "iOS";
        parameters["systemVersion"] = UIDevice.current.systemVersion;
        parameters["productVersion"] = CommonUtil.currentProductVersion();
        parameters["uniqueId"] = ASIdentifierManager.shared().advertisingIdentifier.uuidString;
        parameters["productName"] = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String;
        parameters["appKey"] = "ruidai";
        
        self.post(HTTPConstants.INITIAL, parameters: parameters) { (json) in
            self.appInfo = AppInfo();
            self.appInfo.appId = json["appId"].object as? String;
            self.appInfo.appKey = json["key"].object as? String;
            self.onCompleteSuccess();
        }
    }
}
