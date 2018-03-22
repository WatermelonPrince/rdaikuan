//
//  LoanApplyListService.swift
//  Loan
//
//  Created by zhaohuan on 2017/8/30.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class Apply: BaseModel {
    var applyId : String?
    var userId : String?
    var productId : String?
    var productName : String?
    var applyTimeStr : String?
    var loanAmountStr : String?
    var productLogo : String?
    var repayDaysStr : String?
    var statusTags : Tags?

}

class LoanApplyListService: BaseService {
    var paginator : Paginator!
    var applyList : Array<Apply>!
    
    func getApplyList(token : String?, productId : String?, merchantId : String?){
        if LotteryUtil.appKey() == nil {
            //当APPID为空时，初始化失败，需要再次调用inital接口
            AppDelegate.context.initial();
        }
        let parameters = ["token":token!,"productId":productId ?? nil,"merchantId":merchantId ?? nil];
        self.get(HTTPConstants.APPLYLIST, parameters: parameters) { (json) in
            self.paginator = Paginator.deserialize(from: json["paginator"].rawString());
            self.applyList = [Apply].deserialize(from: json["applyList"].rawString()) as! Array<Apply>;
            self.onCompleteSuccess();
            
        }
        
    }

}

class LoanApplyListLoadMoreService: BaseService {
    var paginator : Paginator!
    var applyList : Array<Apply>!
    
    func getApplyList(token : String?, productId : String?, merchantId : String?, limit : String?, page : String?){
        if LotteryUtil.appKey() == nil {
            //当APPID为空时，初始化失败，需要再次调用inital接口
            AppDelegate.context.initial();
        }
        let parameters = ["token":token!,"productId":productId ?? nil,"merchantId":merchantId ?? nil,"page":page ?? nil,"limit":limit ?? nil];
        self.get(HTTPConstants.APPLYLIST, parameters: parameters) { (json) in
            self.paginator = Paginator.deserialize(from: json["paginator"].rawString());
            self.applyList = [Apply].deserialize(from: json["applyList"].rawString()) as! Array<Apply>;
            self.onCompleteSuccess();
            
        }
        
    }
    
}


class LoanApplyCommitService: BaseService {
   
    
    func applyCommit(token : String?, productId : String?,status : String?){
        if LotteryUtil.appKey() == nil {
            //当APPID为空时，初始化失败，需要再次调用inital接口
            AppDelegate.context.initial();
        }
        let parameters = ["token":token!,"productId":productId ?? nil,"status":status ?? nil];
        self.get(HTTPConstants.APPLYCOMMIT, parameters: parameters) { (json) in
            
            self.onCompleteSuccess();
            
        }
        
    }
    
}
