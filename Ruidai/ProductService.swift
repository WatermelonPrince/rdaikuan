//
//  ProductService.swift
//  Loan
//
//  Created by zhaohuan on 2017/8/29.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class ProductService: BaseService {
    var product : Product?
    
    func applyProductDetail(productId:String?){
        if LotteryUtil.appKey() == nil {
            //当APPID为空时，初始化失败，需要再次调用inital接口
            AppDelegate.context.initial();
        }
        let parameter = ["productId":productId ?? nil];
        self.get(HTTPConstants.PRODUCTDETAIL, parameters: parameter, success: { (json) in
            self.product = Product.deserialize(from: json["product"].rawString());
            self.onCompleteSuccess();
        }) { (json) -> Bool in
            
            self.onCompleteFail();
            return false;
        }
        
    }

}
