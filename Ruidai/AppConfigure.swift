//
//  AppConfigure.swift
//  Loan
//
//  Created by zhaohuan on 2017/9/15.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class AppConfigure {
    
    var adCache = NSCache<AnyObject, AnyObject>();
    var netAlertView: LoanAlertrReplaceView?;
    
    class var shareAppConfigure: AppConfigure {
        struct Static {
            static let instace : AppConfigure = AppConfigure();
        }
        return Static.instace;
    }
    
    
    func advertisementShowOrHidden(adModel : Advertisement?) -> (Bool){
        if adModel == nil {
            return false;
        }
        if (adModel?.showType == nil || adModel?.showType == "") {
            print("广告showType为空");
            return false;
        }
        guard let imageUrl = adModel?.imageUrl else {
            print("广告imageUrl为nil");
            return false;
        }
        if adModel?.showType == "1" {
            if self.adCache.object(forKey: imageUrl as AnyObject) != nil {
                return false;
            }else{
                self.adCache.setObject(true as AnyObject, forKey: imageUrl as AnyObject);
                return true;
            }
            
        }else if(adModel?.showType == "2"){
            if adModel?.cycleTime == nil || adModel?.cycleTime == 0 {
                return false;
            }
            guard let value = UserDefaults.standard.object(forKey: (imageUrl as NSString).xh_md5 + (adModel?.position ?? "")) else {
                let date = Date.init(timeIntervalSinceNow: 0);
                let interval = date.timeIntervalSince1970;
                UserDefaults.standard.set(Double(interval), forKey: (imageUrl as NSString).xh_md5 + (adModel?.position ?? ""));
                UserDefaults.standard.synchronize();
                return true;
            }
            let date = Date.init(timeIntervalSinceNow: 0);
            let interval = date.timeIntervalSince1970;
            let minus = Double(interval) - (value as! Double)
            if minus < (adModel?.cycleTime!)! {
                return false;
            }else{
                UserDefaults.standard.set(Double(interval), forKey: (imageUrl as NSString).xh_md5 + (adModel?.position ?? ""));
                UserDefaults.standard.synchronize();
                return true;
            }
            
        }else if(adModel?.showType == "3"){
            guard UserDefaults.standard.object(forKey: (imageUrl as NSString).xh_md5 + (adModel?.position ?? "")) != nil else {
                UserDefaults.standard.set(true, forKey: (imageUrl as NSString).xh_md5 + (adModel?.position ?? ""));
                UserDefaults.standard.synchronize();
                return true;
            }
            return false;
        }
        return false;
    }
    
    
    func isNewUser() -> Bool {
        guard let value = UserDefaults.standard.object(forKey: "INITTIME") else {
            return true;
        }
        let date = Date.init(timeIntervalSinceNow: 0);
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "yyyy-MM-dd";
        let dateStr = dateFormatter.string(from: date);
        if (value as! String) != dateStr {
            return false;
        }else{
            return true;
        }
    }
    
    func upDateUMClickEvent(event:String){
        if self.isNewUser() == true && LotteryUtil.isLogin() == true {
            let eventId = "\(event)_nl";
            MobClick.event(eventId);
            return;
        }
        if self.isNewUser() == false && LotteryUtil.isLogin() == false {
            let eventId = "\(event)_ou";
            MobClick.event(eventId);
            return;
        }
        if self.isNewUser() == true && LotteryUtil.isLogin() == false {
            let eventId = "\(event)_nu";
            MobClick.event(eventId);
            return;
        }
        if self.isNewUser() == false && LotteryUtil.isLogin() == true {
            let eventId = "\(event)_ol";
            MobClick.event(eventId);
            return;
        }
        
    }

}
