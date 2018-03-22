//
//  AccurateMatchService.swift
//  Ruidai
//
//  Created by zhaohuan on 2017/10/17.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class AccurateMatchInfoService: BaseService {
    var loanAmountRuler: ProductRuler?
    var repayDayRuler: ProductRuler?
    var repayMonthRuler: ProductRuler?
    var searchContent: String?
    var searchTags: Array<Tags>?
    var repaymentContent: String?
    var repaymentTags: Array<Tags>?
    
    func getAccurateMatchInfo(){
        if LotteryUtil.appKey() == nil {
            //当APPID为空时，初始化失败，需要再次调用inital接口
            AppDelegate.context.initial();
        }
        self.get(HTTPConstants.ACCURATEMATCHINFO, parameters: nil) { (json) in
            self.loanAmountRuler = ProductRuler.deserialize(from: json["loanAmountRuler"].rawString());
            self.repayDayRuler = ProductRuler.deserialize(from: json["repayDayRuler"].rawString());
            self.repayMonthRuler = ProductRuler.deserialize(from: json["repayMonthRuler"].rawString());
            self.searchContent = json["searchContent"].object as? String;
            self.repaymentContent = json["repaymentContent"].object as? String;
            self.searchTags = [Tags].deserialize(from: json["searchTags"].rawString()) as? Array<Tags>;
            self.repaymentTags = [Tags].deserialize(from: json["repaymentTags"].rawString()) as? Array<Tags>;
            self.onCompleteSuccess();
            
        }
        
    }
    
    

}
