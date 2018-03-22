//
//  ProductRecommendService.swift
//  Loan
//
//  Created by zhaohuan on 2017/9/18.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class ProductRecommendService: BaseService {
    var luckList = Array<String>()

    func getLuckList(productId : String?){
        if LotteryUtil.appKey() == nil {
            //当APPID为空时，初始化失败，需要再次调用inital接口
            AppDelegate.context.initial();
        }
        if productId != nil {
            let parameter = ["productId" : productId]
            self.get(HTTPConstants.LUCKLIST, parameters: parameter, success: { (json) in
                guard let array = json["luckList"].arrayObject else{
                    return;
                }
                self.luckList = (array as? Array<String>)!;
                self.onCompleteSuccess();
            })

        }
    }

}
