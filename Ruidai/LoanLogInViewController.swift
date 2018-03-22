//
//  MobileRegisterViewController.swift
//  Lottery
//
//  Created by DTY on 17/3/30.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class SwithView: UIView {
    var verLoginButton : UIButton!;
    var passWordLoginButton : UIButton!;
    var lineView : UIView!;
    var transLineView : UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.verLoginButton = UIButton(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH/2, height: 48));
        self.verLoginButton.titleLabel?.font = UIFont.systemFont(ofSize: 15);
        self.verLoginButton.setTitle("验证码登录", for: .normal);
        self.verLoginButton.setTitleColor(COLOR_FONT_HEAD, for: .normal);
        self.verLoginButton.setTitleColor(COLOR_BLUE, for: .selected);
        self.passWordLoginButton = UIButton(frame: CGRect(x: self.verLoginButton.right(), y: self.verLoginButton.top(), width: SCREEN_WIDTH/2, height: 48));
        self.passWordLoginButton.titleLabel?.font = UIFont.systemFont(ofSize: 15);
        self.passWordLoginButton.setTitle("密码登录", for: .normal);
        self.passWordLoginButton.setTitleColor(COLOR_FONT_HEAD, for: .normal);
        self.passWordLoginButton.setTitleColor(COLOR_BLUE, for: .selected);
        self.lineView = UIView(frame: CGRect(x: 0, y: self.verLoginButton.bottom() + 0.5, width: SCREEN_WIDTH, height: 1));
        self.lineView.backgroundColor = COLOR_BORDER;
        self.transLineView = UIView(frame: CGRect(x: 0, y: self.verLoginButton.bottom(), width: SCREEN_WIDTH/2, height: 2));
        self.transLineView.backgroundColor = COLOR_BLUE;
            
        self.addSubview(self.verLoginButton);
        self.addSubview(self.passWordLoginButton);
        self.addSubview(self.lineView);
        self.addSubview(self.transLineView);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class LoanVerifyLoginBasicViewController: CommonBaseScrollViewController, ServiceDelegate {
    var mobileView: MobileTextFieldView!;
    var passwordView: PasswordTextFieldView!;
    var verifyView: VerifyTextFieldView!;
    var voiceVerifyButton: VoiceVerifyButton!;
    var actionButton: CommonBaseButton!;
    var userService: UserService!;
    var smsService: SmsService!;
    var smsType = SmsService.TYPE_REGISTER;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = COLOR_GROUND;
        
        //手机号
        self.mobileView = MobileTextFieldView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: CommonBaseTextFieldView.baseHeight));
        self.scrollView.addSubview(self.mobileView);
        
        //密码
        self.passwordView = NewPasswordTextFieldView(frame: CGRect(x: 0, y: self.mobileView.frame.maxY + 1, width: self.view.frame.width, height: self.mobileView.frame.height));
        self.scrollView.addSubview(self.passwordView);
        
        //验证码
        self.verifyView = VerifyTextFieldView(frame: CGRect(x: 0, y: self.passwordView.frame.maxY, width: self.view.frame.width, height: self.passwordView.frame.height));
        self.scrollView.addSubview(self.verifyView);
        self.verifyView.button.addTarget(self, action: #selector(verifyAction), for: .touchUpInside);
        
        //语音验证码
        self.voiceVerifyButton = VoiceVerifyButton(frame: CGRect(x: self.view.frame.width - 200 - 20, y: self.verifyView.frame.maxY + 10, width: 200, height: 16));
//        self.scrollView.addSubview(self.voiceVerifyButton);
//        self.voiceVerifyButton.addTarget(self, action: #selector(voiceVerifyAction), for: .touchUpInside);
        
        //注册
        self.actionButton = CommonBaseButton(frame: CGRect(x: 20, y: self.verifyView.frame.maxY + 20, width: self.view.frame.width-20*2, height: self.mobileView.frame.height));
        self.actionButton.setTitle("登录", for: .normal);
        self.scrollView.addSubview(self.actionButton);
        
        //Service
        self.smsService = SmsService(delegate: self);
        self.userService = UserService(delegate: self);
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onCompleteSuccess(service: BaseService) {
        
    }
    
    func onCompleteFail(service: BaseService) {
        self.verifyView.verifyTimeInt = 1;
    }
    
    func verifyAction() {
        if ((self.mobileView.textField.text! as NSString).length != 11) {
            ViewUtil.showToast(text: "请输入正确的手机号");
        } else {
            self.verifyView.createVerifyTimer();
            self.smsService.sendSms(mobile: self.mobileView.textField.text!, type: nil);
        }
    }
    
//    func voiceVerifyAction() {
//        if (self.mobileView.textField.text == "") {
//            ViewUtil.showToast(text: "请输入您的手机号");
//        } else {
//            self.smsService.sendVoiceSms(mobile: self.mobileView.textField.text!, type: self.smsType);
//        }
//    }

}


class LoanVerifyLoginViewController: LoanVerifyLoginBasicViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad();
        
        
        self.smsType = SmsService.TYPE_REGISTER;
        self.mobileView.iconImage.image = UIImage.init(named: "icon_loginphone");
        self.verifyView.iconImage.image = UIImage.init(named: "icon_loginver");
        self.mobileView.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged);
        self.verifyView.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged);
        self.passwordView.removeFromSuperview();
        self.verifyView.frame = CGRect(x: 0, y: self.mobileView.frame.maxY, width: self.view.frame.width, height: self.passwordView.frame.height);
        self.actionButton.frame = CGRect(x: 20, y: self.verifyView.frame.maxY + 20, width: self.view.frame.width-20*2, height: self.mobileView.frame.height);
        self.actionButton.setTitle("登录", for: .normal);
        self.actionButton.addTarget(self, action: #selector(verifyLogInAction), for: .touchUpInside);
        self.actionButton.setBackgroundImage(CommonUtil.creatImageWithColor(color: COLOR_BORDER), for: .normal);
        self.actionButton.setBackgroundImage(CommonUtil.creatImageWithColor(color: COLOR_BLUE!), for: .selected);
        self.actionButton.isEnabled = self.actionButton.isSelected;
        self.view.backgroundColor = COLOR_WHITE;
        
       
        
    }
    func textFieldDidChange(textField : UITextField) {
        if ((self.mobileView.textField.text! as NSString).length > 11) {
            ViewUtil.showToast(text: "请输入11位手机号码");
            let reduceStr = (self.mobileView.textField.text! as NSString).substring(to: 11);
            self.mobileView.textField.text = reduceStr;
        }
        if ((self.mobileView.textField.text! as NSString).length == 11) && ((self.verifyView.textField.text! as NSString).length > 0) {
            self.actionButton.isSelected = true;
            self.actionButton.isEnabled = true;
        }else{
            self.actionButton.isSelected = false;
            self.actionButton.isEnabled = false;
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func verifyLogInAction() {
        if (self.mobileView.textField.text == "") {
            ViewUtil.showToast(text: "请输入您的手机号");
        } else if (self.verifyView.textField.text == ""){
            ViewUtil.showToast(text: "请输入验证码");
        } else {
            self.userService.verifyLogInAction(mobile: self.mobileView.textField.text!, smsCode: self.verifyView.textField.text!, from: nil);
            self.mobileView.textField.resignFirstResponder();
            self.passwordView.textField.resignFirstResponder();
            self.verifyView.textField.resignFirstResponder();
        }
    }
    
    override func onCompleteSuccess(service: BaseService) {
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: LoanMineTableViewController.userStatusChangeNotificationName), object: self, userInfo: nil));
        self.dismiss(animated: true, completion: nil);
        LotteryUtil.saveIsWechatLogin(isWechatLogin: false);
    }

}

class LoanLogInViewController: BaseViewController,UIScrollViewDelegate {
    
    var switchView : SwithView!
    var childVerVC : LoanVerifyLoginViewController!
    var childPassWordVC : MobileLoginViewController!
    var horScrollView : UIScrollView!
    
    override func viewDidLoad() {
        
        self.title = "登录";
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .done, target: self, action: #selector(cancelAction));
        
        self.switchView = SwithView(frame: CGRect(x: 0, y: NAVIHEIGHT, width: SCREEN_WIDTH, height: 50));
        self.switchView.verLoginButton.isSelected = true;
        self.view.addSubview(self.switchView);
        self.view.backgroundColor = COLOR_WHITE;
        
        self.childVerVC = LoanVerifyLoginViewController();
        self.childPassWordVC = MobileLoginViewController();
        
        self.addChildViewController(self.childVerVC);

        self.addChildViewController(self.childPassWordVC);
        
        self.horScrollView = UIScrollView(frame: CGRect(x: 0, y: self.switchView.bottom(), width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 114));
        self.horScrollView.contentSize = CGSize(width: self.view.frame.width * 2, height: SCREEN_HEIGHT-64 - 50);
        self.automaticallyAdjustsScrollViewInsets = false;
        self.horScrollView.isPagingEnabled = true;
        self.view.addSubview(self.horScrollView);
        self.childVerVC.view.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 114);
        self.horScrollView.addSubview(self.childVerVC.view);
        self.childPassWordVC.view.frame = CGRect(x: SCREEN_WIDTH, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 114);
        self.horScrollView.addSubview(self.childPassWordVC.view);
        self.horScrollView.delegate = self;
        self.switchView.verLoginButton.addTarget(self, action: #selector(changeLogInStyle), for: .touchUpInside);
        self.switchView.passWordLoginButton.addTarget(self, action: #selector(changeLogInStyle), for: .touchUpInside);
    }
    
    
    
    func changeLogInStyle(action:UIButton){
        if action.currentTitle == "验证码登录" {
            self.switchView.transLineView.frame = CGRect(x: 0, y: 48, width: SCREEN_WIDTH/2, height: 2);
            self.switchView.verLoginButton.isSelected = true;
            self.switchView.passWordLoginButton.isSelected = false;
            
            self.horScrollView.setContentOffset(CGPoint(x : 0, y : 0), animated: true);

        }else{
            self.switchView.transLineView.frame = CGRect(x: SCREEN_WIDTH/2, y: 48, width: SCREEN_WIDTH/2, height: 2);
            self.switchView.verLoginButton.isSelected = false;

            self.switchView.passWordLoginButton.isSelected = true;
            self.horScrollView.setContentOffset(CGPoint(x : SCREEN_WIDTH, y : 0), animated: true);

        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x/SCREEN_WIDTH;
        if page == 0 {
            self.switchView.transLineView.frame = CGRect(x: 0, y: 48, width: SCREEN_WIDTH/2, height: 2);
            self.switchView.verLoginButton.isSelected = true;
            self.switchView.passWordLoginButton.isSelected = false;
        }else{
            self.switchView.transLineView.frame = CGRect(x: SCREEN_WIDTH/2, y: 48, width: SCREEN_WIDTH/2, height: 2);
            self.switchView.verLoginButton.isSelected = false;
            
            
            self.switchView.passWordLoginButton.isSelected = true;
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
//        self.childVerVC.verifyView.verifyTimer?.invalidate();
//        self.childVerVC.verifyView.verifyTimer = nil;
    }
    
    func cancelAction() {
        self.childVerVC.verifyView.verifyTimer?.invalidate();
        self.childVerVC.verifyView.verifyTimer = nil;
        self.dismiss(animated: true, completion: nil);
       
        
    }
    
}
