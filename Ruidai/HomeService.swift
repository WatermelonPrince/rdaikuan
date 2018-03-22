//
//  HomeService.swift
//  Lottery
//
//  Created by DTY on 2017/4/24.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class Paginator: BaseModel {
    var page : String?
    var limit: String?
    var nextPage: String?
    var hasNextPage: Bool = true
    var totalCount: Int?

}

class ApplySucAdService: BaseService {
    var applySucAd: Advertisement?
    func getPromotionAd(productId: String?,client: String?){
        if LotteryUtil.appKey() == nil {
            //当APPID为空时，初始化失败，需要再次调用inital接口
            AppDelegate.context.initial();
        }
        let parameters = ["productId": productId ?? "","client":client ?? "1"];
        self.get(HTTPConstants.APPLYSUCAD, parameters: parameters) { (json) in
            self.applySucAd = Advertisement.deserialize(from: json["promotionAd"].rawString()!);
            self.onCompleteSuccess();
            
        }
        
    }
    
}

class HomeService: BaseService, ServiceDelegate {
    var appService: AppService?;
    var bannerList: Array<Advertisement>!;
    var cornerBanner: Banner!;
    var productList: Array<Product>!;
    var paginator: Paginator!
    var connerAd : Advertisement!
    var popupAd : Advertisement!
    var applyCount: Int?
    var searchImageUrl: String?
    var productCategorys: Array<ProductCategory>!
    var noticeList: Array<NoticeVo>!
    var loanAmountTags: Array<Tags>?
    var tabBarTitle: String?
    
    
    
    func getHome() {
        if (LotteryUtil.appKey() == nil) {
            //当APPID为空时，初始化失败，需要再次调用inital接口
            let appId = LotteryUtil.appId();
            let appKey = LotteryUtil.appKey();
   
            //当appID和appKey丢失重新请求  并存储
            if (appId == nil || appKey == nil) {
                //AppService
                
                self.appService = AppService(delegate: self);
                self.appService?.initialApp();
            }
        } else {
            doGetHome();
        }
    }
    
    func doGetHome() {
        self.get(HTTPConstants.HOME, parameters: nil) { (json) in
            self.bannerList = [Advertisement].deserialize(from: json["bannerList"].rawString()!) as? Array<Advertisement>;
            self.cornerBanner = Banner.deserialize(from: json["cornerBanner"].rawString()!);
            self.productList = [Product].deserialize(from: json["productList"].rawString()!) as? Array<Product>;
            self.paginator = Paginator.deserialize(from: json["paginator"].rawString()!);
            self.connerAd = Advertisement.deserialize(from: json["connerAd"].rawString()!);
            self.popupAd = Advertisement.deserialize(from: json["popupAd"].rawString()!);
            self.productCategorys = [ProductCategory].deserialize(from: json["productCategorys"].rawString()!) as? Array<ProductCategory>;
            self.noticeList = [NoticeVo].deserialize(from: json["noticeList"].rawString()!) as? Array<NoticeVo>;
            self.loanAmountTags = [Tags].deserialize(from: json["loanAmountTags"].rawString()) as? Array<Tags>;
            self.applyCount = json["applyCount"].object as? Int;
            self.searchImageUrl = json["searchImageUrl"].object as? String;
            self.tabBarTitle = json["tabBar"].object as? String;
            self.onCompleteSuccess();
        }
    }

    func onCompleteSuccess(service: BaseService){
        LotteryUtil.saveAppId(appId: self.appService?.appInfo?.appId);
        LotteryUtil.saveAppKey(appKey: self.appService?.appInfo.appKey);
        doGetHome();
    }
}


class HomeLoadMoreService: BaseService {
    var bannerList: Array<Banner>!;
    var cornerBanner: Banner!;
    var productList: Array<Product>!;
    var paginator: Paginator!
    var connerAd : Advertisement!
    var popupAd : Advertisement!
    var loanAmountTags: Array<Tags>?

    
    
    func getHomeLoadMore(nextPage:String?,limit:String?) {
        if LotteryUtil.appKey() == nil {
            //当APPID为空时，初始化失败，需要再次调用inital接口
            AppDelegate.context.initial();
        }
        let parameter = ["page":nextPage ?? "1","limit":limit ?? "10"];
        self.get(HTTPConstants.HOME, parameters: parameter) { (json) in
           
            self.productList = [Product].deserialize(from: json["productList"].rawString()!) as? Array<Product>;
            self.paginator = Paginator.deserialize(from: json["paginator"].rawString()!);
            self.connerAd = Advertisement.deserialize(from: json["connerAd"].rawString()!);
            self.popupAd = Advertisement.deserialize(from: json["popupAd"].rawString()!);
            self.loanAmountTags = [Tags].deserialize(from: json["loanAmountTags"].rawString()) as? Array<Tags>;
            self.onCompleteSuccess();
        }
    }
    
}
