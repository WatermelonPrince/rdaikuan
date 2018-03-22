//
//  FeedbackService.swift
//  Lottery
//
//  Created by zhaohuan on 2017/8/7.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class FeedbackService: BaseService {
    
    func commitFeedback(userId:String?,mobile:String?,name:String?,email:String?,message:String) {
        if LotteryUtil.appKey() == nil {
            //当APPID为空时，初始化失败，需要再次调用inital接口
            AppDelegate.context.initial();
        }
        let parameters = ["userId":userId ?? nil,"mobile":mobile ?? nil,"name":name ?? nil,"email":email ?? nil,"message":message ];
        self.get(HTTPConstants.FEEDBACK, parameters: parameters) { (json) in
            self.onCompleteSuccess();
        }
    }

}


