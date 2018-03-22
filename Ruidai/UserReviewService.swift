//
//  UserReviewService.swift
//  Ruidai
//
//  Created by zhaohuan on 2017/10/12.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class UserReviewService: BaseService {
    var positiveRate: Int?
    var commentList : Array<CommentVo>?;
    var rateSatisfaction: Int?
    var loanSatisfaction: Int?
    var processSatisfaction: Int?
    var paginator: Paginator?
    var isOwned: Int?


    
    
    func getCommanList(productId: String?){
        if LotteryUtil.appKey() == nil {
            //当APPID为空时，初始化失败，需要再次调用inital接口
            AppDelegate.context.initial();
        }
        let parameters = ["productId": productId ?? "", "page": "1", "limit": "10"];
        self.get(HTTPConstants.COMMENLIST, parameters: parameters, success: { (json) in
            self.positiveRate = json["positiveRate"].object as? Int;
            self.rateSatisfaction = json["rateSatisfaction"].object as? Int;
            self.loanSatisfaction = json["loanSatisfaction"].object as? Int;
            self.processSatisfaction = json["processSatisfaction"].object as? Int;
            self.commentList = ([CommentVo].deserialize(from: json["commentList"].rawString()!) as? Array<CommentVo>)!;
            self.paginator = Paginator.deserialize(from: json["paginator"].rawString()!);

            
            
            
            self.onCompleteSuccess();
            
        }) { (json) -> Bool in
            self.onCompleteFail();
            return false;
        }
    }

}

class UserReviewLoadMoreService: BaseService {
    var positiveRate: Int?
    var commentList : Array<CommentVo>?;
    var rateSatisfaction: Int?
    var loanSatisfaction: Int?
    var processSatisfaction: Int?
    var paginator: Paginator?
    
    func getCommenListLoadMore(nextPage:String?,limit:String?,productId:String?){
        if LotteryUtil.appKey() == nil {
            //当APPID为空时，初始化失败，需要再次调用inital接口
            AppDelegate.context.initial();
        }
        let parameter = ["page":nextPage ?? "1","limit":limit ?? "10","productId": productId ?? ""];
        self.get(HTTPConstants.COMMENLIST, parameters: parameter, success: { (json) in
            
            self.positiveRate = json["positiveRate"].object as? Int;
            self.rateSatisfaction = json["rateSatisfaction"].object as? Int;
            self.loanSatisfaction = json["loanSatisfaction"].object as? Int;
            self.processSatisfaction = json["processSatisfaction"].object as? Int;
            self.commentList = ([CommentVo].deserialize(from: json["commentList"].rawString()!) as? Array<CommentVo>)!;
            self.paginator = Paginator.deserialize(from: json["paginator"].rawString()!);
            
            self.onCompleteSuccess();
            
        }) { (json) -> Bool in
            
            self.onCompleteFail();
            return false;
            
        }

        
    }


    
}
