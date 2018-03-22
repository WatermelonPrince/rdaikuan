//
//  CommonHttpRequest.swift
//  Lottery
//
//  Created by DTY on 2017/4/10.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit
import CoreTelephony


class CommonHttpRequest: NSObject {
    var alertVC : UIAlertController?
    
    func get(_ URLString: String, parameters: Any?, success:((JSON) -> Void)?) {
        self.get(URLString, parameters: parameters, success: success, fail: nil);
    }
    
    func get(_ URLString: String, parameters: Any?, success:((JSON) -> Void)?, fail:((JSON) -> Bool)?) {
        self.request(URLString, parameters: parameters, dataBlock: nil, success: success, fail: fail, requestType: 0, isEncrypt: nil);
    }
    
    func get(_ URLString: String, urlParameters: String?, success:((JSON) -> Void)?) {
        self.get(URLString, urlParameters: urlParameters, success: success, fail: nil);
    }
    
    func get(_ URLString: String, urlParameters: String?, success:((JSON) -> Void)?, fail:((JSON) -> Bool)?) {
        var URLString = URLString;
        if (urlParameters != nil && urlParameters != "") {
            URLString = URLString + "/" + urlParameters!;
        }
        self.request(URLString, parameters: nil, dataBlock: nil, success: success, fail: fail, requestType: 0, isEncrypt: nil);
    }
    
    func post(_ URLString: String, parameters: Any?, success:((JSON) -> Void)?) {
        self.post(URLString, parameters: parameters, success: success, fail: nil);
    }
    
    func post(_ URLString: String, parameters: Any?, success:((JSON) -> Void)?, fail:((JSON) -> Bool)?) {
        self.request(URLString, parameters: parameters, dataBlock: nil, success: success, fail: fail, requestType: 1, isEncrypt: nil);
    }
    
    func post(_ URLString: String, encryptParameters: Any?, success:((JSON) -> Void)?) {
        self.post(URLString, encryptParameters: encryptParameters, success: success, fail: nil);
    }
    
    func post(_ URLString: String, encryptParameters: Any?, success:((JSON) -> Void)?, fail:((JSON) -> Bool)?) {
        self.request(URLString, parameters: encryptParameters, dataBlock: nil, success: success, fail: fail, requestType: 1, isEncrypt: true);
    }
    //上传图片
    func modifyPicture(_ URLString: String, encryptParameters: Any?, dataBlock:((_ formData:AFMultipartFormData)->())?, success:((JSON) -> Void)?, fail:((JSON) -> Bool)?){
        self.request(URLString, parameters: encryptParameters, dataBlock: dataBlock, success: success, fail: fail, requestType: 3, isEncrypt: false);
    }
    
    func encryptRequestParameters(_ parameters: Dictionary<String, String>) -> Dictionary<String, Any> {
        var result = Dictionary<String, Any>();
        result["appId"] = LotteryUtil.appId();
        var params = String();
        for (key, value) in parameters {
            params = params + key + "=" + value + "&";
        }
        let paramsData = params.data(using: String.Encoding.utf8);
        //转换成加密需要的data
        let appKeyData = AESCryptService.base16Data(LotteryUtil.appKey());
        //AES加密参数， 加密key是由initApp时服务器传过来的的
        let encryptParams = AESCryptService.base16String(AESCryptService.aes256Encrypt(paramsData, withKey: appKeyData));
        result["params"] = encryptParams;
        return result;
    }
    
    func request(_ URLString: String, parameters: Any?, dataBlock:((_ formData:AFMultipartFormData)->())?,success:((JSON) -> Void)?, fail:((JSON) -> Bool)?, requestType: Int, isEncrypt: Bool?) {
        //判断当前网络权限
        
        
        let manager = AFHTTPSessionManager();
        
        //Success
        let success:((URLSessionDataTask, Any?) -> Void)? = { (task, data) in
            let json = JSON.init(data: data as! Data);
            if (json["retCode"].int == CommonRetCode.SUCCESS) {
                success!(json);
            } else if (fail?(json) != true) {
                //此种情况只在AFN请求中成功但错误码并不等于200的时候会出现

                //通用错误处理
                if (json["retDesc"].null == nil) {
                    let text = json["retDesc"].string;
                    if (text != nil) {
                        ViewUtil.showToast(text: text!);
                    }
                }
                ViewUtil.dismissToast();

                self.onCompleteFail();
            }
            
        }
        
        //Failure
        let failure:((URLSessionDataTask?, Error) -> Void)? = { (task, error) in
//            ViewUtil.showToast(text: error.localizedDescription);
            ViewUtil.dismissToast();
            //此种情况只在AFN请求中出现错误时会回调
            if #available(iOS 9.0, *) {
                let cellularData = CTCellularData();
                cellularData.cellularDataRestrictionDidUpdateNotifier = {
                    (state) in
                    if state == .restricted{
                        
                    DispatchQueue.main.async(execute: {
                        self.performNetAlert();
                    });
                        
                    }else if state == .notRestricted{
                        print("权限没打开");
                    }else if state == .restrictedStateUnknown{
                        print("权限未知");
                    }
                }
            }

            self.onCompleteFail();
        }
        
        //Parameters
        var parameters = parameters as? Dictionary<String, Any>;
        if (parameters == nil) {
            parameters = Dictionary<String, Any>();
        }
        if (LotteryUtil.token() != nil) {
            parameters?["token"] = LotteryUtil.token();
        }
        if (LotteryUtil.appId() != nil) {
            parameters?["appId"] = LotteryUtil.appId();
        }
        if (isEncrypt == true) {
             parameters = self.encryptRequestParameters(parameters as! Dictionary<String, String>);
        }
        parameters?["pt"] = "r";
        
        
        //Request
        let requestSerializer = AFHTTPRequestSerializer();
//        requestSerializer.willChangeValue(forKey: "timeoutInterval");
//        requestSerializer.timeoutInterval = 10;
//        requestSerializer.didChangeValue(forKey: "timeoutInterval");
        manager.requestSerializer = requestSerializer;
        if requestType == 3 {
            for (key,value) in parameters! {
                manager.requestSerializer.setValue(value as? String, forHTTPHeaderField: key);
            }
        }
        
        //Response
        let responseSerializer = AFHTTPResponseSerializer();
        responseSerializer.acceptableContentTypes = ["text/html"];
        manager.responseSerializer = responseSerializer;
    
        if (requestType == 0) {//get
            manager.get(URLString, parameters: parameters, progress: nil, success: success, failure: failure);
        } else if(requestType == 1){//post
            manager.post(URLString, parameters: parameters, progress: nil, success: success, failure: failure);
        }else{
            manager.post(URLString, parameters: parameters, constructingBodyWith: dataBlock, progress: nil, success: success, failure: failure);
        }
        
    }
    
    
    func performNetAlert(){
        if AppConfigure.shareAppConfigure.netAlertView != nil {
            AppConfigure.shareAppConfigure.netAlertView?.isHidden = false;
        }else{
            AppConfigure.shareAppConfigure.netAlertView = LoanAlertrReplaceView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT));
            UIApplication.shared.keyWindow?.addSubview(AppConfigure.shareAppConfigure.netAlertView!);
            AppConfigure.shareAppConfigure.netAlertView?.isHidden = false;
        }
       
    }

    
    func onCompleteFail() {
        
    }

}
