//
//  LoanActivityService.swift
//  Jubaodai
//
//  Created by zhaohuan on 2017/12/7.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LoanActivityPreService: BaseService {
    var activityStepList: Array<ActivityStep>?
    
    func getActivityPre(activityKey: String?,client: String?){
        let parameters = ["activityKey":activityKey ?? "","client": client ?? "1"];
        
        self.get(HTTPConstants.ACTIVITYPRE, parameters: parameters) { (json) in
           
            self.activityStepList = [ActivityStep].deserialize(from: json["activityStepList"].rawString()) as? Array<ActivityStep>;
            self.onCompleteSuccess();
            
            
        }
    }
    

}
