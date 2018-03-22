//
//  StatisticsService.swift
//  Loan
//
//  Created by zhaohuan on 2017/9/1.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class StatisticsService: BaseService {
    
    func sendStatistics(id:String?,channel:String?,position:String?,appId:String?,adStat:String?){
        if LotteryUtil.appKey() == nil {
            //当APPID为空时，初始化失败，需要再次调用inital接口
            AppDelegate.context.initial();
        }
        let parameter = ["id":id ?? nil,"channel":channel ?? nil,"position":position ?? nil,"appId": appId ?? nil,"adStat":adStat ?? nil];
        self.get(HTTPConstants.APPSTATISTICS, parameters: parameter) { (json) in
            print("统计上传成功");
        }
    }
    
    func sendProductStatistics(productId:String?){
        if LotteryUtil.appKey() == nil {
            //当APPID为空时，初始化失败，需要再次调用inital接口
            AppDelegate.context.initial();
        }
        let parameter = ["productId":productId ?? nil];
        self.get(HTTPConstants.PRODUCTSTATIS, parameters: parameter) { (json) in
            print("点击详情统计成功");
        }
    }

}
