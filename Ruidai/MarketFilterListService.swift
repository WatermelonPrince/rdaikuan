//
//  MarketFilterListService.swift
//  Ruidai
//
//  Created by zhaohuan on 2017/10/20.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class MarketFilterListLoadMoreService: BaseService {
    var paginator: Paginator?
    var productList: Array<Product>?
    
    func getMarketFilterListLoadMore(authorizeTags: String?,loanAmount: String?,sortCondition: String?,repayMethod: String?,repayDays: String?,categoryId: String?,nextPage: String?,limit: String?){
        if LotteryUtil.appKey() == nil {
            //当APPID为空时，初始化失败，需要再次调用inital接口
            AppDelegate.context.initial();
        }
        ViewUtil.showProgressToast();
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
        
        if nextPage != nil {
            parameters["page"] = nextPage;
        }
        if limit != nil {
            parameters["limit"] = limit;
        }
        
        
        
        
        self.get(HTTPConstants.FILTERLIST, parameters: parameters) { (json) in
            self.productList = [Product].deserialize(from: json["productList"].rawString()) as? Array<Product>;
            self.paginator = Paginator.deserialize(from: json["paginator"].rawString());
            
            self.onCompleteSuccess();
            
            
        }
    }


}

class MarketFilterListService: BaseService {
    
    var productList: Array<Product>?
    var paginator: Paginator?
    
    func getMarketFilterList(authorizeTags: String?,loanAmount: String?,sortCondition: String?,repayMethod: String?,repayDays: String?,categoryId: String?){
        if LotteryUtil.appKey() == nil {
            //当APPID为空时，初始化失败，需要再次调用inital接口
            AppDelegate.context.initial();
        }
        ViewUtil.showProgressToast();
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
        
        
        
        
        
        self.get(HTTPConstants.FILTERLIST, parameters: parameters) { (json) in
            self.productList = [Product].deserialize(from: json["productList"].rawString()) as? Array<Product>;
            self.paginator = Paginator.deserialize(from: json["paginator"].rawString());
            
            self.onCompleteSuccess();
            
            
        }
    }

    
    

}
