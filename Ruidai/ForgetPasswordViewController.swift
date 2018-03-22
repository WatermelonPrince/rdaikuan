//
//  ForgetPasswordViewController.swift
//  Lottery
//
//  Created by DTY on 2017/4/27.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: LoanVerifyLoginBasicViewController {

    override func viewDidLoad() {
        super.viewDidLoad();
        self.title = "找回密码";
        self.smsType = SmsService.TYPE_RESETPASSWD;
        //手机号
        self.mobileView.label.frame = CGRect(x: 15, y: 15, width: 15*4, height: 20);
        self.mobileView.label.text = "手机号：";
        self.mobileView.iconImage.frame = CGRect(x: self.mobileView.label.right() + 10, y: self.mobileView.iconImage.top(), width: 0, height: 0);
        //密码
        self.passwordView.label.frame = CGRect(x: 15, y: 15, width: 15*4, height: 20);
        self.passwordView.label.text = "密码：";
        self.passwordView.iconImage.frame = CGRect(x: self.passwordView.label.right() + 10, y: self.passwordView.iconImage.top(), width: 0, height: 0);
        self.passwordView.codeInputStyleBtn.addTarget(self, action: #selector(showOrHiddenCodeAction), for: .touchUpInside);
        self.passwordView.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged);
         self.verifyView.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged);
         self.mobileView.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged);
        self.passwordView.textField.placeholder = "请输入6-16位新密码";
        //验证码
        self.verifyView.label.frame = CGRect(x: 15, y: 15, width: 15*4, height: 20);
        self.verifyView.label.text = "验证码：";
        self.verifyView.iconImage.frame = CGRect(x: self.verifyView.label.right() + 10, y: self.verifyView.iconImage.top(), width: 0, height: 0);
        
        self.actionButton.setTitle("提交", for: .normal);
        self.actionButton.addTarget(self, action: #selector(submitAction), for: .touchUpInside);
        
        self.actionButton.setBackgroundImage(CommonUtil.creatImageWithColor(color: COLOR_BORDER), for: .normal);
        self.actionButton.setBackgroundImage(CommonUtil.creatImageWithColor(color: COLOR_BLUE!), for: .selected);
        self.actionButton.isEnabled = self.actionButton.isSelected;
        self.view.backgroundColor = COLOR_WHITE;
        
        if #available(iOS 11.0, *) {
            self.scrollView.frame = CGRect(x: self.scrollView.left(), y: self.scrollView.top() + NAVIHEIGHT, width: self.scrollView.width(), height:self.scrollView.height() );

        }
        
       
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func submitAction() {
        if ((self.mobileView.textField.text! as NSString).length != 11) {
            ViewUtil.showToast(text: "请输入您的手机号");
        } else if (self.passwordView.textField.text == ""){
            ViewUtil.showToast(text: "请输入新密码");
        } else if (self.verifyView.textField.text == ""){
            ViewUtil.showToast(text: "请输入验证码");
        } else {
            self.userService.forgetPassword(mobile: self.mobileView.textField.text!, password: self.passwordView.textField.text!, smsCode: self.verifyView.textField.text!);
        }
    }
    
    func textFieldDidChange(textField : UITextField) {
        if ((self.mobileView.textField.text! as NSString).length > 11) {
            ViewUtil.showToast(text: "请输入11位手机号码");
            let reduceStr = (self.mobileView.textField.text! as NSString).substring(to: 11);
            self.mobileView.textField.text = reduceStr;
        }
        if ((self.mobileView.textField.text! as NSString).length == 11) && ((self.passwordView.textField.text! as NSString).length > 0) &&  ((self.verifyView.textField.text! as NSString).length > 0){
            self.actionButton.isSelected = true;
            self.actionButton.isEnabled = true;
        }else{
            self.actionButton.isSelected = false;
            self.actionButton.isEnabled = false;
        }
    }
    
    func showOrHiddenCodeAction(action:UIButton){
        self.passwordView.codeInputStyleBtn.isSelected = !action.isSelected;
        self.passwordView.textField.isSecureTextEntry = !action.isSelected;
        
    }
    
    override func onCompleteSuccess(service: BaseService) {
        _ = self.navigationController?.popViewController(animated: true);
    }

}
