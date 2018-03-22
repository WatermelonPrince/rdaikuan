//
//  HostRouter.swift
//  Lottery
//
//  Created by DTY on 17/2/16.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import Foundation

//注册添加的的一些路由信息，能根据url指向目标控制器，并控制目标控制器的初始化

class HostRouter : NSObject{
    static let stasticService = StatisticsService();
    
    static let HOST = "honghongcai";
    static let JUMP_HOST = HOST + "://";
    static let LOGIN = "/login";
    static let PAY = "/pay";
    static let ARTICLELIST = "/articleList"
    static let WELFARELIST = "/welfareList"
    static let PRODUCTDETAIL = "/productDetail";
    static let CATEGORYPRODUCTLIST = "/categoryProductList";

    
    static func registerRoutes() {
        
        LoanRoutes.addRoute("http/*") { (param: [AnyHashable: Any]?) -> Bool in
            let parameters = param! as NSDictionary;
            let urlContent = ((parameters[kJLRouteURLKey] as! NSURL).absoluteString)!;
            
            let vc = CommonWebViewController();
            vc.urlContent = urlContent;
            ViewUtil.keyViewController().pushViewController(viewController: vc);
            return true;
        }
        
        LoanRoutes.addRoute("https/*") { (param: [AnyHashable: Any]?) -> Bool in
            let parameters = param! as NSDictionary;
            let urlContent = ((parameters[kJLRouteURLKey] as! NSURL).absoluteString)!;
            let vc = CommonWebViewController();
            vc.urlContent = urlContent;
            ViewUtil.keyViewController().pushViewController(viewController: vc);
            return true;
        }
        
        LoanRoutes.addRoute(LOGIN) { (param: [AnyHashable: Any]?) -> Bool in
            let vc = CommonBaseNavigationController(rootViewController: LoanLogInViewController());
            ViewUtil.keyViewController().present(vc, animated: true, completion: nil);
            return true;
        }
        
        
        
       //分类productLIst,首页图片
        
        LoanRoutes.addRoute(CATEGORYPRODUCTLIST) { (param:[AnyHashable : Any]?) -> Bool in
            let vc = PushLoanMarketViewController();
            vc.categoryId = param?["categoryId"] as? String;
            ViewUtil.keyViewController().pushViewController(viewController: vc);
            
           
            
            return true;
        }
        

        
        //福利类别列表
        LoanRoutes.addRoute(WELFARELIST) { (param:[AnyHashable : Any]?) -> Bool in
            let vc = FuliCatagoryListViewController();
            vc.catagoryId = param?["categoryId"] as! String;
            ViewUtil.keyViewController().pushViewController(viewController: vc);
            
            //统计
            let id = param?["id"] as? String;
            let channel = param?["channel"] as? String;
            let position = param?["position"] as? String;
            let adStat = param?["adStat"] as? String;
            AppContext().sendStatistics(id: id, channel: channel, position: position, appId: nil, adStat: adStat);
            
            return true;
        }
        
        //贷款详情
        LoanRoutes.addRoute(PRODUCTDETAIL) { (param:[AnyHashable : Any]?) -> Bool in
            let vc = LoanDetailViewController();
            vc.productId = param?["productId"] as? String;
            vc.hidesBottomBarWhenPushed = true;
            ViewUtil.keyViewController().pushViewController(viewController: vc);
            
            //统计
            let id = param?["id"] as? String;
            let channel = LotteryUtil.user()?.channel ?? "AppStorer";
            let position = param?["position"] as? String;
            let adStat = param?["adStat"] as? String;
            AppContext().sendStatistics(id: id, channel: channel, position: position, appId: nil, adStat: adStat);
            AppContext().sendProductStatis(productId: vc.productId);
            
            return true;
        }
        
        
    }
    
}
