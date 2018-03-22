//
//  MarketFilterInfoService.swift
//  Ruidai
//
//  Created by zhaohuan on 2017/10/17.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class MarketFilterInfoService: BaseService {
    var searchContent : String?
    var searchTags : Array<Tags>?
    var repaymentTags: Array<Tags>?
    var loanAmountTags : Array<Tags>?
    var filterTags: Array<Tags>?
    var repaymentContent: String?
    
    
    var authorizeTags : String?
    var loanAmount: String?
    var sortCondition: String?
    var repayMethod: String?
    var repayDays: String?
    
    func getFilterConditionInfo(authorizeTags: String?,loanAmount: String?,sortCondition: String?,repayMethod: String?,repayDays: String?,categoryId: String?){
        if LotteryUtil.appKey() == nil {
            //当APPID为空时，初始化失败，需要再次调用inital接口
            AppDelegate.context.initial();
        }
        var parameters = Dictionary<String, Any>();
        if authorizeTags != nil {
            parameters["authorizeTags"] = authorizeTags;
        }
        if loanAmount != nil {
            parameters["loanAmount"] = loanAmount;
        }
        if sortCondition != nil {
            parameters["sortCondition"] = sortCondition;
        }
        if repayMethod != nil {
            parameters["repayMethod"] = repayMethod;
        }
        if repayDays != nil {
            parameters["repayDays"] = repayDays;
        }
        if categoryId != nil {
            parameters["categoryId"] = categoryId;
        }
        
        
        
        
        self.get(HTTPConstants.FILTERINFO, parameters: parameters) { (json) in
            self.searchContent = json["searchContent"].object as? String;
            self.repaymentContent = json["searchContent"].object as? String;
            self.filterTags = [Tags].deserialize(from: json["filterTags"].rawString()) as? Array<Tags>;
            self.loanAmountTags = [Tags].deserialize(from: json["loanAmountTags"].rawString()) as? Array<Tags>;
            self.searchTags = [Tags].deserialize(from: json["searchTags"].rawString()) as? Array<Tags>;
            self.repaymentTags = [Tags].deserialize(from: json["repaymentTags"].rawString()) as? Array<Tags>;
            
            self.onCompleteSuccess();
            
            
        }
    }

}
