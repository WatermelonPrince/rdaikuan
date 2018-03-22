//
//  UserService.swift
//  Lottery
//
//  Created by DTY on 2017/4/21.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class UserService: BaseService {
    var tempToken: String?;
    var avatarUrl : String?;
    
    func login(mobile: String, password: String) {
        if LotteryUtil.appKey() == nil {
            AppDelegate.context.initial();
        }
        var parameters = Dictionary<String, String>();
        parameters["mobile"] = mobile;
        parameters["password"] = password;
        ViewUtil.showProgressToast();
        self.post(HTTPConstants.LOGIN, encryptParameters: parameters) { (json) in
            let loginToken = LoginToken.deserialize(from: json["loginToken"].rawString());
            loginToken?.user?.bindAlias = "ios_" + (loginToken?.user?.bindAlias ?? "");
            self.setLoginToken(loginToken);
            //用户关联推送
            GeTuiSdk.bindAlias(LotteryUtil.user()?.bindAlias, andSequenceNum: LotteryUtil.user()?.bindAlias);
            MobClick.profileSignIn(withPUID: LotteryUtil.user()?.userId)

            ViewUtil.dismissToast();
            self.onCompleteSuccess();
            
            //登录统计
            AppConfigure.shareAppConfigure.upDateUMClickEvent(event: "login");
        }
    }
    
    func wxLogin(code: String) {
        if LotteryUtil.appKey() == nil {
            AppDelegate.context.initial();
        }
        var parameters = Dictionary<String, String>();
        parameters["code"] = code;
        ViewUtil.showProgressToast();
        self.post(HTTPConstants.WX_LOGIN, encryptParameters: parameters) { (json) in
            let loginToken = LoginToken.deserialize(from: json["loginToken"].rawString());
            loginToken?.user?.bindAlias = "ios_" + (loginToken?.user?.bindAlias ?? "");
            self.setLoginToken(loginToken);
            //用户关联推送
            GeTuiSdk.bindAlias(LotteryUtil.user()?.bindAlias, andSequenceNum: LotteryUtil.user()?.bindAlias);
            MobClick.profileSignIn(withPUID: LotteryUtil.user()?.userId);
            UMAnalyticsConfig.sharedInstance().channelId = loginToken?.user?.channel ?? "AppStorer";
            ViewUtil.dismissToast();
            self.onCompleteSuccess();
        }
    }
    
    func getUser() {
        if (LotteryUtil.token() == nil) {
            self.onCompleteFail();
            return;
        }
        if LotteryUtil.appKey() == nil {
            AppDelegate.context.initial();
        }
        var parameters = Dictionary<String, String>();
        parameters["token"] = LotteryUtil.token();
        self.post(HTTPConstants.LOGIN_BY_TOKEN, encryptParameters: parameters) { (json) in
            let loginToken = LoginToken.deserialize(from: json["loginToken"].rawString());
            loginToken?.user?.bindAlias = "ios_" + (loginToken?.user?.bindAlias ?? "");
            self.setLoginToken(loginToken);
            self.onCompleteSuccess();
        }
    }
    
    func verifyLogInAction(mobile: String, smsCode: String, from: String?) {
        if LotteryUtil.appKey() == nil {
            //当APPID为空时，初始化失败，需要再次调用inital接口
            AppDelegate.context.initial();
        }
        var parameters = Dictionary<String, String>();
        parameters["mobile"] = mobile;
        parameters["smsCode"] = smsCode;
        parameters["from"] = from;
        ViewUtil.showProgressToast();
        self.post(HTTPConstants.LOGIN_BY_SMS, encryptParameters: parameters) { (json) in
            let loginToken = LoginToken.deserialize(from: json["loginToken"].rawString());
            ViewUtil.showToast(text: "登录成功");
            loginToken?.user?.bindAlias = "ios_" + (loginToken?.user?.bindAlias ?? "");
            self.setLoginToken(loginToken);
            //用户关联推送
            GeTuiSdk.bindAlias(LotteryUtil.user()?.bindAlias, andSequenceNum: LotteryUtil.user()?.bindAlias);
            MobClick.profileSignIn(withPUID: LotteryUtil.user()?.userId);
            UMAnalyticsConfig.sharedInstance().channelId = loginToken?.user?.channel ?? "AppStorer";
            ViewUtil.dismissToast();
            self.onCompleteSuccess();
            
            //登录统计
            AppConfigure.shareAppConfigure.upDateUMClickEvent(event: "login");
        }
    }
    
    func forgetPassword(mobile: String, password: String, smsCode: String) {
        if LotteryUtil.appKey() == nil {
            //当APPID为空时，初始化失败，需要再次调用inital接口
            AppDelegate.context.initial();
        }
        var parameters = Dictionary<String, String>();
        parameters["mobile"] = mobile;
        parameters["password"] = password;
        parameters["smsCode"] = smsCode;
        ViewUtil.showProgressToast();
        self.post(HTTPConstants.FORGET_PASSWORD, encryptParameters: parameters) { (json) in
            ViewUtil.showToast(text: "请重新登录");
            self.onCompleteSuccess();
        }
    }
    
    func changePassword(password: String) {
        if LotteryUtil.appKey() == nil {
            //当APPID为空时，初始化失败，需要再次调用inital接口
            AppDelegate.context.initial();
        }
        var parameters = Dictionary<String, String>();
        parameters["password"] = password;
        ViewUtil.showProgressToast();
        self.post(HTTPConstants.CHANGE_PASSWORD, encryptParameters: parameters) { (json) in
            ViewUtil.showToast(text: "密码修改成功");
            self.onCompleteSuccess();
        }
    }
    
    func setLoginToken(_ loginToken: LoginToken?) {
        if LotteryUtil.appKey() == nil {
            //当APPID为空时，初始化失败，需要再次调用inital接口
            AppDelegate.context.initial();
        }
        if (loginToken != nil) {
            LotteryUtil.saveToken(token: loginToken?.token);
            LotteryUtil.saveUser(user: loginToken?.user);
           

        }
    }
    
    func getTempToken() {
        if LotteryUtil.appKey() == nil {
            //当APPID为空时，初始化失败，需要再次调用inital接口
            AppDelegate.context.initial();
        }
        var parameters = Dictionary<String,String>();
        parameters["token"] = LotteryUtil.token();
        self.post(HTTPConstants.GET_TEMP_TOKEN, encryptParameters: parameters, success: { (json) in
            let tempToken = json["tempToken"].object as? String;
            self.tempToken = tempToken;
            self.onCompleteSuccess();
        }) { (json) -> Bool in
            //失败
            self.onCompleteFail();
            return true;
        }
    }
    
    func commitInfo(name: String) {
        if LotteryUtil.appKey() == nil {
            //当APPID为空时，初始化失败，需要再次调用inital接口
            AppDelegate.context.initial();
        }
        var parameters = Dictionary<String, Any>();
        parameters["name"] = name;
        self.post(HTTPConstants.COMMIT_INFO, parameters: parameters) { (json) in
            self.onCompleteSuccess();
        }
    }
    
    //修改头像
    func resetAvatarImage(file:UIImage?,filePath:String?){
        if LotteryUtil.appKey() == nil {
            //当APPID为空时，初始化失败，需要再次调用inital接口
            AppDelegate.context.initial();
        }
        guard let file = file,let filePath = filePath else {
            return;
        }
        let parameter = NSDictionary();
        if file.isKind(of: UIImage.classForCoder()) {
            self.modifyPicture(HTTPConstants.RESET_AVATAR, encryptParameters: parameter, dataBlock: { (formData) in
                let path = filePath.cacheDir();
               
                do {
                    try UIImageJPEGRepresentation(file, 0.5)?.write(to: URL(fileURLWithPath: path));
                    try formData.appendPart(withFileURL: URL(fileURLWithPath: path), name: "file", fileName: "123.PNG", mimeType: "image/png");
                    
                }catch{
                    print("上传图片有误");
                };
                
            }, success: { (json) in
                self.avatarUrl = json["avatarUrl"].object as? String;
                 NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: LoanMineTableViewController.userStatusChangeNotificationName), object: self, userInfo: nil));
                self.onCompleteSuccess();
            }, fail: nil);
        }
    }
    
    

}
