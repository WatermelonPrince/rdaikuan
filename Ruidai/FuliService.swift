//
//  FuliService.swift
//  Loan
//
//  Created by zhaohuan on 2017/8/28.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class AdvertisementCategory: BaseModel {
    var categoryId : Int!
    var name : String!
    var description : String!
    var image : String!
    var advertisements : Array<Advertisement>!
    var type: Int?
    

}

class Advertisement: BaseModel {
    var advertisementId : Int?
    var title : String?
    var subTitle : String?
    var link : String?
    var imageUrl : String?
    var count : String?
    var buttonName : String?
    var categoryDesc : String?
    var showType : String?
    var cycleTime : Double?
    var position : String?
   

    
}

class FuliObject: BaseModel {
    var categoryList : Array<AdvertisementCategory>!
    var bannerList : Array<Advertisement>!
    var tagsList : Array<Advertisement>!
    var popupAd : Advertisement?
    var connerAd : Advertisement?

}

class FuliService: BaseService {
    var fuliObject : FuliObject!
    var welfarelistArr = Array<AdvertisementCategory>();
    
    
    func getFuli() {
        if LotteryUtil.appKey() == nil {
            //当APPID为空时，初始化失败，需要再次调用inital接口
            AppDelegate.context.initial();
        }
        
        self.get(HTTPConstants.FULI, parameters: ["channel":LotteryUtil.user()?.channel ?? "AppStorer"]) { (json) in
           self.fuliObject = FuliObject.deserialize(from:json.rawString())!;
            
        
            self.onCompleteSuccess();


        }
    }
    
    

}

class FuliCatagoryService: BaseService {
    var category : AdvertisementCategory!
    var advertisements : Array<Advertisement>!
    
    
    
    func getCatagoryList(catogoryId : String){
        if LotteryUtil.appKey() == nil {
            //当APPID为空时，初始化失败，需要再次调用inital接口
            AppDelegate.context.initial();
        }
        let parameters = ["categoryId":catogoryId,"channel":LotteryUtil.user()?.channel ?? "AppStorer"];
        self.get(HTTPConstants.FULILIST, parameters: parameters) { (json) in
            self.advertisements = [Advertisement].deserialize(from: json["advertisements"].rawString()!) as? Array<Advertisement>!
            self.category = AdvertisementCategory.deserialize(from: json["category"].rawString());
            self.onCompleteSuccess();

        }
    }
    
}


