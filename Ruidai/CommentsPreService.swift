//
//  SubmitCommentsInfoService.swift
//  Ruidai
//
//  Created by zhaohuan on 2017/10/16.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class CommentsPreService: BaseService {
    
    var product : Product?
    var statusList : Array<String>?
    
    func getSubmitCommentInfo(productId : String?){
        if LotteryUtil.appKey() == nil {
            //当APPID为空时，初始化失败，需要再次调用inital接口
            AppDelegate.context.initial();
        }
        let parameters = ["productId" : productId ?? ""];
        self.get(HTTPConstants.COMMENTPRE, parameters: parameters) { (json) in
            self.product = Product.deserialize(from: json["product"].rawString()!);
            self.statusList = json["statusList"].object as? Array<String>;
            self.onCompleteSuccess();
        }
    }

}

class CommitCommentsService: BaseService {
    
    
    func commitCommentsInfo(productId : String?,applyStatus: Int?,content: String?,rateSatisfaction: Int?,loanSatisfaction: Int?,processSatisfaction: Int?){
        if LotteryUtil.appKey() == nil {
            //当APPID为空时，初始化失败，需要再次调用inital接口
            AppDelegate.context.initial();
        }
        let parameters = ["productId": productId ?? "","applyStatus": String(applyStatus ?? -1),"content": content ?? "","rateSatisfaction": String(rateSatisfaction ?? 5),"loanSatisfaction": String(loanSatisfaction ?? 5),"processSatisfaction": String(processSatisfaction ?? 5)];
        self.get(HTTPConstants.COMMENTCOMMIT, parameters: parameters) { (json) in
            self.onCompleteSuccess();
        }
        
        

    }
}
