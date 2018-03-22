//
//  AppContext.swift
//  Lottery
//
//  Created by DTY on 2017/4/21.
//  Copyright © 2017年 caipiao. All rights reserved.


import UIKit

//APP的配置信息，包括一些配置历史用户信息，

class AppContext: NSObject, ServiceDelegate {
    static let APP_ID = "appId";
    static let APP_KEY = "appKey";
    static let TOKEN = "token";
    static let CACHE_RAM = NSCache<AnyObject, AnyObject>();
    
    var appService: AppService?;
    var statisService : StatisticsService?
    
    func initial(){
        
        
        let appId = LotteryUtil.appId();
        let appKey = LotteryUtil.appKey();
        
        
        
        //当appID和appKey丢失重新请求  并存储
        if (appId == nil || appKey == nil) {
            //AppService
            if self.appService == nil {
                self.appService = AppService(delegate: self);
            }
            self.appService?.initialApp();
        }
    }
    
   
   
    
    func sendStatistics(id:String?,channel:String?,position:String?,appId:String?,adStat:String?){
        self.statisService = StatisticsService(delegate: self);
        self.statisService?.sendStatistics(id: id ?? nil, channel: channel ?? nil, position: position ?? nil, appId: appId ?? nil, adStat: adStat ?? nil);
    }
    
    func sendProductStatis(productId : String?){
        self.statisService = StatisticsService(delegate: self);
        self.statisService?.sendProductStatistics(productId: productId);

    }
    
    func onCompleteSuccess(service: BaseService){
        LotteryUtil.saveAppId(appId: self.appService?.appInfo?.appId);
        LotteryUtil.saveAppKey(appKey: self.appService?.appInfo.appKey);
    }

}
