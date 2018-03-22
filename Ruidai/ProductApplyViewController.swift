//
//  ProductApplyViewController.swift
//  Loan
//
//  Created by zhaohuan on 2017/9/18.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class ProductApplyViewController: CommonWebViewController {
    
    var productId : String?
    var reconmandView : ProductRecommendView?;
    var reconmandService : ProductRecommendService?;
    var luckList : Array<String>?;
    var applyCommitService : LoanApplyCommitService!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.reconmandService = ProductRecommendService(delegate: self);
        self.applyCommitService = LoanApplyCommitService(delegate:self);

        if self.productId != nil {
            self.reconmandService?.getLuckList(productId: self.productId);
        }
        
    }
    
    override func onCompleteSuccess(service: BaseService) {
        super.onCompleteSuccess(service: service);
        if service.isKind(of: (reconmandService?.classForCoder)!) {
            guard let arr = self.reconmandService?.luckList else {
                return;
            }
            self.luckList = arr;
        }
    }
    
    override func backAction() {
        self.view.endEditing(true);

        if (self.webView.canGoBack) {
            self.webView.goBack();
        } else {
            if (self.luckList != nil){
                self.reconmandView = ProductRecommendView(frame: self.view.frame);
                self.reconmandView?.reloadViewWithModel(modelArr: self.luckList!);
                self.reconmandView?.applySuccessHanlder = { () in
                    self.navigationController?.popToRootViewController(animated: false);
                    self.tabBarController?.selectedIndex = 0;
                    
                }
                UIApplication.shared.keyWindow?.addSubview(self.reconmandView!);
            }else{
                _ = self.navigationController?.popViewController(animated: true);
            }
        }
    }
    
    override func dismissAction() {
        self.view.endEditing(true);

        if (self.luckList != nil){
            self.reconmandView = ProductRecommendView(frame: self.view.frame);
            self.reconmandView?.reloadViewWithModel(modelArr: self.luckList!);
            self.reconmandView?.applySuccessHanlder = { () in
                self.navigationController?.popToRootViewController(animated: false);
                self.tabBarController?.selectedIndex = 0;
                
            }
            UIApplication.shared.keyWindow?.addSubview(self.reconmandView!);
        }else{
            _ = self.navigationController?.popViewController(animated: true);
        }
    }
    
    override func navBackAction() {
        self.view.endEditing(true);

        if (self.luckList != nil){
            self.reconmandView = ProductRecommendView(frame: self.view.frame);
            self.reconmandView?.reloadViewWithModel(modelArr: self.luckList!);
            self.reconmandView?.applySuccessHanlder = { () in
                self.navigationController?.popToRootViewController(animated: false);
                self.tabBarController?.selectedIndex = 0;
                self.applyCommitService.applyCommit(token: LotteryUtil.token(), productId: String(describing: self.productId!),status: "2");
                if self.productId != nil{
                    NotificationCenter.default.post(Notification.init(name: Notification.Name.init(APPLYSUCNOTI), object: self, userInfo: ["productId":self.productId ?? ""]));
                }
                
            }
            UIApplication.shared.keyWindow?.addSubview(self.reconmandView!);
        }else{
            _ = self.navigationController?.popViewController(animated: true);
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
